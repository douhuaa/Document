# 代码注释优化提示词

## 提示词类别
- [ ] 代码生成
- [x] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [x] 文档生成
- [ ] 代码重构

## 应用场景
为现有代码添加高质量的注释，包括函数说明、复杂逻辑解释、API文档注释等。

## 提示词内容

### 1. 函数注释生成
```
// 为以下函数添加详细的注释
// 注释标准：${JSDoc/PyDoc/GoDoc/XML Doc等}
// 包含内容：功能描述、参数说明、返回值、异常、示例
// 注释语言：${中文/英文}
// 详细程度：${简洁/标准/详细}

${需要添加注释的函数代码}
```

### 2. 复杂逻辑注释
```
// 为以下复杂代码添加逐行解释注释
// 重点说明：算法思路、关键步骤、边界处理
// 注释风格：${行内注释/块注释/分段说明}
// 目标读者：${初级/中级/高级开发者}

${复杂的算法或业务逻辑代码}
```

### 3. 类/模块注释
```
// 为以下类或模块添加完整的文档注释
// 包含内容：类的用途、设计模式、使用示例、注意事项
// 关联说明：依赖关系、继承关系、接口实现
// 版本信息：创建时间、作者、版本历史

${类或模块代码}
```

## 示例输入

```javascript
// 为以下函数添加详细的注释
// 注释标准：JSDoc
// 包含内容：功能描述、参数说明、返回值、异常、示例
// 注释语言：中文
// 详细程度：详细

function processUserData(users, filters, options) {
    const result = [];
    const cache = new Map();
    
    for (const user of users) {
        if (!user || typeof user !== 'object') continue;
        
        const cacheKey = `${user.id}_${JSON.stringify(filters)}`;
        if (cache.has(cacheKey)) {
            result.push(cache.get(cacheKey));
            continue;
        }
        
        let isMatch = true;
        for (const [key, value] of Object.entries(filters)) {
            if (user[key] !== value) {
                isMatch = false;
                break;
            }
        }
        
        if (isMatch) {
            const processed = {
                ...user,
                fullName: `${user.firstName} ${user.lastName}`,
                isActive: user.lastLoginDate > Date.now() - (options.activeDays || 30) * 24 * 60 * 60 * 1000
            };
            
            if (options.includeMetadata) {
                processed.metadata = {
                    processedAt: new Date(),
                    version: options.version || '1.0'
                };
            }
            
            cache.set(cacheKey, processed);
            result.push(processed);
        }
    }
    
    return options.sortBy ? result.sort((a, b) => a[options.sortBy].localeCompare(b[options.sortBy])) : result;
}
```

## 预期输出

```javascript
/**
 * 处理用户数据并应用筛选条件
 * 
 * 该函数接收用户数据数组，根据指定的筛选条件进行过滤，
 * 并对符合条件的用户数据进行处理和格式化。支持缓存机制以提升性能。
 * 
 * @param {Object[]} users - 用户数据数组
 * @param {Object} users[].id - 用户唯一标识符
 * @param {string} users[].firstName - 用户名字
 * @param {string} users[].lastName - 用户姓氏
 * @param {number} users[].lastLoginDate - 最后登录时间戳
 * 
 * @param {Object} filters - 筛选条件对象
 * @param {*} filters.* - 筛选字段名和对应的值，支持任意字段的精确匹配
 * 
 * @param {Object} options - 处理选项配置
 * @param {number} [options.activeDays=30] - 判断用户活跃的天数阈值，默认30天
 * @param {boolean} [options.includeMetadata=false] - 是否在结果中包含元数据信息
 * @param {string} [options.version='1.0'] - 处理版本号，用于元数据记录
 * @param {string} [options.sortBy] - 排序字段名，如果指定则对结果进行排序
 * 
 * @returns {Object[]} 处理后的用户数据数组
 * @returns {string} returns[].fullName - 用户全名（名字+姓氏）
 * @returns {boolean} returns[].isActive - 用户是否在活跃期内
 * @returns {Object} [returns[].metadata] - 元数据信息（当 includeMetadata 为 true 时）
 * @returns {Date} [returns[].metadata.processedAt] - 处理时间
 * @returns {string} [returns[].metadata.version] - 处理版本号
 * 
 * @throws {TypeError} 当 users 不是数组时抛出类型错误
 * @throws {Error} 当筛选条件格式不正确时可能出现错误
 * 
 * @example
 * // 基础使用示例
 * const users = [
 *   { id: 1, firstName: '张', lastName: '三', department: '技术部', lastLoginDate: Date.now() },
 *   { id: 2, firstName: '李', lastName: '四', department: '市场部', lastLoginDate: Date.now() - 86400000 }
 * ];
 * 
 * const filters = { department: '技术部' };
 * const options = { activeDays: 7, includeMetadata: true };
 * 
 * const result = processUserData(users, filters, options);
 * // 返回: [{ id: 1, firstName: '张', lastName: '三', fullName: '张 三', 
 * //          isActive: true, metadata: { processedAt: ..., version: '1.0' } }]
 * 
 * @example
 * // 带排序的使用示例
 * const sortedResult = processUserData(users, {}, { sortBy: 'fullName' });
 * // 返回按 fullName 排序的用户列表
 * 
 * @since 1.0.0
 * @author 开发团队
 * @see {@link getUsersByDepartment} 获取特定部门用户的相关函数
 */
function processUserData(users, filters, options) {
    // 输入验证：确保 users 是数组
    if (!Array.isArray(users)) {
        throw new TypeError('users 参数必须是数组类型');
    }
    
    // 初始化结果数组和缓存
    const result = [];
    const cache = new Map(); // 使用 Map 缓存处理结果，提升重复查询性能
    
    // 遍历所有用户数据
    for (const user of users) {
        // 数据有效性检查：跳过 null、undefined 或非对象类型的数据
        if (!user || typeof user !== 'object') continue;
        
        // 生成缓存键：基于用户ID和筛选条件
        const cacheKey = `${user.id}_${JSON.stringify(filters)}`;
        
        // 缓存命中检查：如果已处理过相同条件的用户，直接使用缓存结果
        if (cache.has(cacheKey)) {
            result.push(cache.get(cacheKey));
            continue;
        }
        
        // 筛选条件匹配检查
        let isMatch = true;
        
        // 遍历所有筛选条件，进行精确匹配
        for (const [key, value] of Object.entries(filters)) {
            if (user[key] !== value) {
                isMatch = false;
                break; // 任一条件不匹配即可跳出循环
            }
        }
        
        // 如果用户符合筛选条件，进行数据处理
        if (isMatch) {
            // 构建处理后的用户对象
            const processed = {
                ...user, // 保留原有所有属性
                
                // 生成全名：组合名字和姓氏
                fullName: `${user.firstName} ${user.lastName}`,
                
                // 计算用户活跃状态：基于最后登录时间和活跃天数阈值
                isActive: user.lastLoginDate > Date.now() - (options.activeDays || 30) * 24 * 60 * 60 * 1000
            };
            
            // 根据配置添加元数据信息
            if (options.includeMetadata) {
                processed.metadata = {
                    processedAt: new Date(), // 处理时间戳
                    version: options.version || '1.0' // 版本信息
                };
            }
            
            // 缓存处理结果，避免重复计算
            cache.set(cacheKey, processed);
            result.push(processed);
        }
    }
    
    // 根据配置进行排序：如果指定了排序字段，使用本地化字符串比较
    return options.sortBy 
        ? result.sort((a, b) => a[options.sortBy].localeCompare(b[options.sortBy])) 
        : result;
}
```

```javascript
/**
 * 用户数据处理工具类
 * 
 * 提供用户数据的筛选、处理、缓存等功能的综合解决方案。
 * 采用单例模式设计，支持多种数据源和处理策略。
 * 
 * @class UserDataProcessor
 * @version 2.0.0
 * @author 数据处理团队 <data-team@company.com>
 * @since 1.0.0
 * 
 * @example
 * // 创建处理器实例
 * const processor = new UserDataProcessor({
 *   cacheSize: 1000,
 *   defaultActiveDays: 30
 * });
 * 
 * // 处理用户数据
 * const result = await processor.process(userData, filters);
 */
class UserDataProcessor {
    /**
     * 构造函数
     * @param {Object} config - 配置对象
     * @param {number} [config.cacheSize=500] - 缓存大小限制
     * @param {number} [config.defaultActiveDays=30] - 默认活跃天数
     */
    constructor(config = {}) {
        // 配置初始化
        this.config = {
            cacheSize: config.cacheSize || 500,
            defaultActiveDays: config.defaultActiveDays || 30,
            ...config
        };
        
        // 缓存系统初始化：使用 LRU 策略
        this.cache = new Map();
        this.cacheStats = { hits: 0, misses: 0 };
    }
    
    // ... 其他方法的注释
}
```

## 使用技巧
- 根据代码复杂度调整注释详细程度
- 优先注释公开接口和复杂算法
- 使用标准的文档注释格式（JSDoc等）
- 包含实际的使用示例
- 及时更新注释以保持与代码同步

## 效果评估
**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接
- [[documentation-templates]]
- [[code-generation-basics]]
- [[api-integration]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #comments #documentation #jsdoc*