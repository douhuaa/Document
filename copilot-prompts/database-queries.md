# 数据库查询优化提示词

## 提示词类别

- [x] 代码生成
- [x] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [ ] 文档生成
- [ ] 代码重构

## 应用场景

用于生成高效的数据库查询代码，包括SQL优化、ORM使用、连接池管理和查询性能调优。

## 提示词内容

### 1. SQL查询生成与优化

```javascript
// 创建SQL查询来实现以下需求：
// 业务需求：${具体的查询需求描述}
// 涉及表：${相关表名和关系}
// 查询条件：${WHERE条件说明}
// 排序要求：${ORDER BY需求}
// 分页需求：${是否需要分页，每页数量}
// 性能要求：${预期查询时间和数据量}
// 索引建议：${需要考虑的索引优化}
```javascript

### 2. ORM查询模式生成

```javascript
// 使用 ${ORM框架名称} 创建查询
// 实体/模型：${相关的实体类}
// 查询类型：${查找单个/列表/聚合等}
// 关联查询：${需要JOIN的关联关系}
// 条件筛选：${动态查询条件}
// 缓存策略：${是否需要查询缓存}
// 分页排序：${分页和排序需求}
```javascript

### 3. 数据库连接管理

```javascript
// 创建数据库连接管理器
// 数据库类型：${MySQL/PostgreSQL/MongoDB等}
// 连接池配置：最小连接数、最大连接数、超时设置
// 事务管理：${事务隔离级别和回滚策略}
// 错误处理：${连接失败和查询异常处理}
// 监控日志：${性能监控和慢查询日志}
```javascript

## 示例输入

```sql
// 创建SQL查询来实现以下需求：
// 业务需求：获取最近30天内活跃用户的订单统计，包括订单数量和总金额
// 涉及表：users(用户表)、orders(订单表)、user_activities(用户活动表)
// 查询条件：用户最后活动时间在30天内，订单状态为已完成
// 排序要求：按订单总金额降序排列
// 分页需求：每页20条记录
// 性能要求：查询时间不超过2秒，处理10万+用户数据
// 索引建议：需要在活动时间、订单状态和用户ID上创建合适的索引
```javascript

## 预期输出

```sql
-- 索引建议
CREATE INDEX idx_user_activities_last_activity ON user_activities(user_id, last_activity_date);
CREATE INDEX idx_orders_user_status_created ON orders(user_id, status, created_at);
CREATE INDEX idx_orders_status_created ON orders(status, created_at);

-- 优化后的主查询
WITH active_users AS (
    SELECT DISTINCT user_id
    FROM user_activities 
    WHERE last_activity_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
),
user_order_stats AS (
    SELECT 
        o.user_id,
        COUNT(o.id) as order_count,
        COALESCE(SUM(o.total_amount), 0) as total_amount
    FROM orders o
    INNER JOIN active_users au ON o.user_id = au.user_id
    WHERE o.status = 'completed'
        AND o.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    GROUP BY o.user_id
)
SELECT 
    u.id,
    u.username,
    u.email,
    uos.order_count,
    uos.total_amount,
    u.created_at as user_registration_date
FROM users u
INNER JOIN user_order_stats uos ON u.id = uos.user_id
ORDER BY uos.total_amount DESC
LIMIT 20 OFFSET ?; -- 分页参数

-- 获取总记录数的查询（用于分页计算）
SELECT COUNT(DISTINCT u.id) as total_count
FROM users u
INNER JOIN user_activities ua ON u.id = ua.user_id
INNER JOIN orders o ON u.id = o.user_id
WHERE ua.last_activity_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    AND o.status = 'completed'
    AND o.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY);
```javascript

```javascript
// 对应的Node.js查询代码（使用连接池）
const mysql = require('mysql2/promise');

class UserOrderStatsRepository {
    constructor(dbPool) {
        this.pool = dbPool;
    }

    async getActiveUserOrderStats(page = 1, pageSize = 20) {
        const connection = await this.pool.getConnection();
        
        try {
            // 开始事务（如果需要）
            await connection.beginTransaction();
            
            const offset = (page - 1) * pageSize;
            
            // 执行主查询
            const [rows] = await connection.execute(`
                WITH active_users AS (
                    SELECT DISTINCT user_id
                    FROM user_activities 
                    WHERE last_activity_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
                ),
                user_order_stats AS (
                    SELECT 
                        o.user_id,
                        COUNT(o.id) as order_count,
                        COALESCE(SUM(o.total_amount), 0) as total_amount
                    FROM orders o
                    INNER JOIN active_users au ON o.user_id = au.user_id
                    WHERE o.status = 'completed'
                        AND o.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
                    GROUP BY o.user_id
                )
                SELECT 
                    u.id,
                    u.username,
                    u.email,
                    uos.order_count,
                    uos.total_amount,
                    u.created_at as user_registration_date
                FROM users u
                INNER JOIN user_order_stats uos ON u.id = uos.user_id
                ORDER BY uos.total_amount DESC
                LIMIT ? OFFSET ?
            `, [pageSize, offset]);

            // 获取总数
            const [countResult] = await connection.execute(`
                SELECT COUNT(DISTINCT u.id) as total_count
                FROM users u
                INNER JOIN user_activities ua ON u.id = ua.user_id
                INNER JOIN orders o ON u.id = o.user_id
                WHERE ua.last_activity_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
                    AND o.status = 'completed'
                    AND o.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
            `);

            await connection.commit();
            
            return {
                data: rows,
                pagination: {
                    page,
                    pageSize,
                    total: countResult[0].total_count,
                    totalPages: Math.ceil(countResult[0].total_count / pageSize)
                }
            };

        } catch (error) {
            await connection.rollback();
            throw new Error(`查询用户订单统计失败: ${error.message}`);
        } finally {
            connection.release();
        }
    }
}

// 连接池配置
const dbPool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    acquireTimeout: 60000,
    timeout: 60000,
    reconnect: true,
    multipleStatements: false
});

// 使用示例
const repository = new UserOrderStatsRepository(dbPool);

async function getActiveUserStats() {
    try {
        const result = await repository.getActiveUserOrderStats(1, 20);
        console.log('活跃用户订单统计:', result);
        return result;
    } catch (error) {
        console.error('获取统计数据失败:', error);
        throw error;
    }
}
```javascript

## 使用技巧

- 明确指定数据库类型和版本以获得最佳优化建议
- 描述预期的数据量和性能要求
- 说明是否需要实时数据或可以接受一定延迟
- 考虑读写分离和缓存策略
- 包含索引和分区策略的考虑

## 效果评估

**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接

- [[api-integration]]
- [[performance-optimization]]
- [[error-handling]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #database #sql #optimization #performance*
