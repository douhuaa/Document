# API集成开发提示词

## 提示词类别
- [x] 代码生成
- [ ] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [ ] 文档生成
- [ ] 代码重构

## 应用场景
用于生成RESTful API调用代码、GraphQL查询、WebSocket连接等各种API集成相关的代码。

## 提示词内容

### 1. REST API客户端生成
```
// 创建一个API客户端类 ${API名称}Client
// 基础URL：${API基础地址}
// 认证方式：${Bearer Token/API Key/OAuth等}
// 需要的端点：
// - GET ${端点路径}：${功能描述}
// - POST ${端点路径}：${功能描述}
// - PUT ${端点路径}：${功能描述}
// - DELETE ${端点路径}：${功能描述}
// 错误处理：统一的错误处理和重试机制
// 响应格式：JSON
```

### 2. GraphQL查询生成
```
// 创建GraphQL查询函数
// Schema：${GraphQL schema描述}
// 查询类型：${Query/Mutation/Subscription}
// 需要的字段：${列出需要获取的字段}
// 变量：${查询变量及类型}
// 错误处理：${GraphQL错误处理方式}
```

### 3. 异步请求封装
```
// 创建一个通用的HTTP请求函数
// 支持的方法：GET, POST, PUT, DELETE, PATCH
// 功能特性：
// - 自动JSON解析
// - 请求/响应拦截器
// - 超时控制
// - 重试机制
// - 错误统一处理
// - 加载状态管理
```

## 示例输入

```javascript
// 创建一个API客户端类 UserApiClient
// 基础URL：https://api.example.com/v1
// 认证方式：Bearer Token
// 需要的端点：
// - GET /users：获取用户列表，支持分页和筛选
// - POST /users：创建新用户
// - GET /users/{id}：根据ID获取用户详情
// - PUT /users/{id}：更新用户信息
// - DELETE /users/{id}：删除用户
// 错误处理：统一的错误处理和重试机制
// 响应格式：JSON
```

## 预期输出

```javascript
class UserApiClient {
    constructor(baseURL = 'https://api.example.com/v1', token = null) {
        this.baseURL = baseURL;
        this.token = token;
        this.defaultHeaders = {
            'Content-Type': 'application/json',
            ...(token && { 'Authorization': `Bearer ${token}` })
        };
    }

    async request(endpoint, options = {}) {
        const url = `${this.baseURL}${endpoint}`;
        const config = {
            headers: { ...this.defaultHeaders, ...options.headers },
            ...options
        };

        try {
            const response = await fetch(url, config);
            
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            
            return await response.json();
        } catch (error) {
            // 重试机制
            if (options.retries > 0) {
                await new Promise(resolve => setTimeout(resolve, 1000));
                return this.request(endpoint, { ...options, retries: options.retries - 1 });
            }
            throw error;
        }
    }

    // 获取用户列表
    async getUsers(params = {}) {
        const queryString = new URLSearchParams(params).toString();
        const endpoint = `/users${queryString ? `?${queryString}` : ''}`;
        return this.request(endpoint, { method: 'GET', retries: 3 });
    }

    // 创建新用户
    async createUser(userData) {
        return this.request('/users', {
            method: 'POST',
            body: JSON.stringify(userData),
            retries: 2
        });
    }

    // 获取用户详情
    async getUserById(id) {
        return this.request(`/users/${id}`, { method: 'GET', retries: 3 });
    }

    // 更新用户信息
    async updateUser(id, userData) {
        return this.request(`/users/${id}`, {
            method: 'PUT',
            body: JSON.stringify(userData),
            retries: 2
        });
    }

    // 删除用户
    async deleteUser(id) {
        return this.request(`/users/${id}`, { method: 'DELETE', retries: 2 });
    }

    // 设置认证令牌
    setAuthToken(token) {
        this.token = token;
        this.defaultHeaders.Authorization = `Bearer ${token}`;
    }
}
```

## 使用技巧
- 明确指定API的认证方式和安全要求
- 描述需要的错误处理策略（重试、超时等）
- 说明数据格式和序列化要求
- 考虑并发请求和限流处理
- 包含适当的日志和监控需求

## 效果评估
**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接
- [[error-handling]]
- [[rest-api-design]]
- [[unit-test-generation]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #api-integration #rest #graphql*