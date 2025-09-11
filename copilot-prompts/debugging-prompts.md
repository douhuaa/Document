# 调试与问题诊断提示词

## 提示词类别
- [ ] 代码生成
- [x] 代码优化
- [x] 代码解释
- [ ] 测试生成
- [ ] 文档生成
- [x] 代码重构

## 应用场景
用于诊断代码问题、生成调试代码、分析性能瓶颈和修复常见的程序错误。

## 提示词内容

### 1. 代码问题诊断
```
// 分析以下代码中可能存在的问题：
// 问题现象：${具体的错误现象或异常行为}
// 预期行为：${代码应该产生的正确结果}
// 环境信息：${运行环境、依赖版本等}
// 错误日志：${如果有具体的错误信息}
// 请分析可能的原因并提供修复建议

${贴入有问题的代码}
```

### 2. 调试代码生成
```
// 为以下代码添加调试信息
// 调试类型：${console日志/断点/性能监控/内存分析}
// 关注点：${变量状态/函数调用/性能指标/异常捕获}
// 输出格式：${结构化日志/简单打印/性能报告}
// 调试级别：${开发/测试/生产环境}

${需要添加调试的代码}
```

### 3. 性能瓶颈分析
```
// 分析以下代码的性能瓶颈
// 性能问题：${响应慢/内存占用高/CPU使用率高}
// 使用场景：${数据量级、并发量、频次}
// 优化目标：${响应时间/内存使用/吞吐量}
// 约束条件：${兼容性要求/资源限制}

${需要分析的代码}
```

## 示例输入

```javascript
// 分析以下代码中可能存在的问题：
// 问题现象：页面加载很慢，用户列表显示不完整
// 预期行为：快速加载并显示所有用户信息
// 环境信息：React 18, Node.js 16, MySQL数据库
// 错误日志：偶尔出现 "Cannot read property 'map' of undefined"
// 请分析可能的原因并提供修复建议

function UserList() {
    const [users, setUsers] = useState();
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        const response = await fetch('/api/users');
        const data = await response.json();
        setUsers(data);
        setLoading(false);
    };

    return (
        <div>
            {loading && <div>加载中...</div>}
            {users.map(user => (
                <div key={user.id}>{user.name}</div>
            ))}
        </div>
    );
}
```

## 预期输出

```javascript
// 问题分析和修复建议：

/**
 * 发现的问题：
 * 1. users状态初始值为undefined，导致map方法报错
 * 2. loading状态初始值为false，但实际在请求时应该为true
 * 3. 缺少错误处理机制
 * 4. 没有检查response.ok状态
 * 5. 组件卸载时可能产生内存泄漏
 * 6. 缺少数据验证和空值检查
 */

// 修复后的代码：
import React, { useState, useEffect, useRef } from 'react';

function UserList() {
    const [users, setUsers] = useState([]); // 修复1: 初始值改为空数组
    const [loading, setLoading] = useState(true); // 修复2: 初始加载状态为true
    const [error, setError] = useState(null);
    const abortControllerRef = useRef(null); // 用于取消请求

    useEffect(() => {
        fetchUsers();
        
        // 清理函数，防止内存泄漏
        return () => {
            if (abortControllerRef.current) {
                abortControllerRef.current.abort();
            }
        };
    }, []);

    const fetchUsers = async () => {
        try {
            setLoading(true);
            setError(null);
            
            // 创建AbortController用于取消请求
            abortControllerRef.current = new AbortController();
            
            console.log('[UserList] 开始获取用户数据'); // 调试日志
            
            const response = await fetch('/api/users', {
                signal: abortControllerRef.current.signal,
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            // 修复4: 检查响应状态
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }

            const data = await response.json();
            
            // 修复6: 数据验证
            if (!Array.isArray(data)) {
                console.warn('[UserList] 接收到的数据不是数组格式:', data);
                throw new Error('服务器返回的数据格式错误');
            }

            console.log(`[UserList] 成功获取 ${data.length} 个用户`); // 调试日志
            setUsers(data);
            
        } catch (error) {
            // 修复3: 错误处理
            if (error.name === 'AbortError') {
                console.log('[UserList] 请求被取消');
                return;
            }
            
            console.error('[UserList] 获取用户数据失败:', error);
            setError(error.message);
            
            // 生产环境下的用户友好提示
            if (process.env.NODE_ENV === 'production') {
                setError('获取用户数据失败，请稍后重试');
            }
        } finally {
            setLoading(false);
        }
    };

    // 重试机制
    const handleRetry = () => {
        fetchUsers();
    };

    // 渲染优化：避免不必要的重渲染
    const renderUserItem = (user) => {
        // 数据验证：确保必要字段存在
        if (!user || !user.id) {
            console.warn('[UserList] 用户数据缺少必要字段:', user);
            return null;
        }

        return (
            <div key={user.id} className="user-item">
                {user.name || '未知用户'}
            </div>
        );
    };

    // 加载状态
    if (loading) {
        return (
            <div className="loading-container">
                <div>正在加载用户数据...</div>
                <div className="loading-spinner"></div>
            </div>
        );
    }

    // 错误状态
    if (error) {
        return (
            <div className="error-container">
                <div>错误: {error}</div>
                <button onClick={handleRetry}>重试</button>
            </div>
        );
    }

    // 空状态处理
    if (users.length === 0) {
        return (
            <div className="empty-container">
                <div>暂无用户数据</div>
                <button onClick={handleRetry}>刷新</button>
            </div>
        );
    }

    // 正常渲染
    return (
        <div className="user-list">
            <div className="user-count">
                共 {users.length} 个用户
            </div>
            {users.map(renderUserItem)}
        </div>
    );
}

// 性能监控Hook（开发环境使用）
function usePerformanceMonitor(componentName) {
    useEffect(() => {
        if (process.env.NODE_ENV === 'development') {
            const startTime = performance.now();
            
            return () => {
                const endTime = performance.now();
                console.log(`[Performance] ${componentName} 渲染耗时: ${endTime - startTime}ms`);
            };
        }
    });
}

// 使用性能监控的组件
function UserListWithMonitoring() {
    usePerformanceMonitor('UserList');
    return <UserList />;
}

export default UserListWithMonitoring;
```

```javascript
// 后端API优化建议（Node.js + Express）
app.get('/api/users', async (req, res) => {
    try {
        console.time('getUsersQuery'); // 性能监控
        
        // 分页参数
        const page = parseInt(req.query.page) || 1;
        const limit = Math.min(parseInt(req.query.limit) || 50, 100); // 限制最大数量
        const offset = (page - 1) * limit;
        
        // 优化的查询：只获取必要字段，添加索引
        const users = await db.query(`
            SELECT id, name, email, created_at 
            FROM users 
            WHERE active = 1 
            ORDER BY created_at DESC 
            LIMIT ? OFFSET ?
        `, [limit, offset]);
        
        console.timeEnd('getUsersQuery');
        console.log(`[API] 返回 ${users.length} 个用户，页码: ${page}`);
        
        // 添加响应头用于客户端优化
        res.set({
            'Cache-Control': 'public, max-age=300', // 5分钟缓存
            'X-Total-Count': users.length
        });
        
        res.json(users);
        
    } catch (error) {
        console.error('[API] 获取用户列表失败:', error);
        res.status(500).json({ 
            error: '服务器内部错误',
            message: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});
```

## 使用技巧
- 详细描述问题现象，包括错误信息和环境信息
- 提供可复现的最小示例代码
- 说明预期行为和实际行为的差异
- 包含相关的日志信息和错误堆栈
- 考虑性能、安全和用户体验等多个维度

## 效果评估
**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接
- [[error-handling]]
- [[performance-optimization]]
- [[unit-test-generation]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #debugging #troubleshooting #performance*