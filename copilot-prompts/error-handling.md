# 错误处理与异常管理提示词

## 提示词类别

- [x] 代码生成
- [x] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [ ] 文档生成
- [ ] 代码重构

## 应用场景

用于生成健壮的错误处理代码，包括异常捕获、错误恢复、日志记录和用户友好的错误提示。

## 提示词内容

### 1. 通用错误处理封装

```javascript
// 创建一个通用的错误处理函数
// 功能：${错误处理的具体需求}
// 错误类型：${需要处理的错误类型列表}
// 处理策略：${如何处理不同类型的错误}
// 日志级别：${错误日志的记录级别}
// 用户提示：${是否需要向用户显示错误信息}
// 恢复机制：${错误发生后的恢复策略}
```javascript

### 2. 异步操作错误处理

```javascript
// 为以下异步操作添加完整的错误处理
// 操作类型：${API调用/文件操作/数据库查询等}
// 可能的错误：${网络错误/超时/权限不足等}
// 重试策略：${是否需要重试，重试次数和间隔}
// fallback方案：${错误时的备选方案}
// 用户体验：${加载状态和错误提示的处理}

${贴入需要处理的异步代码}
```javascript

### 3. 自定义错误类生成

```javascript
// 创建自定义错误类 ${错误类名}
// 继承：Error 基类
// 属性：错误码、错误消息、错误详情、时间戳
// 方法：格式化输出、日志记录
// 用途：${具体的业务场景}
```javascript

## 示例输入

```javascript
// 为以下异步操作添加完整的错误处理
// 操作类型：API调用获取用户数据
// 可能的错误：网络错误、超时、404用户不存在、500服务器错误
// 重试策略：网络错误重试3次，间隔1秒递增
// fallback方案：使用缓存数据或默认值
// 用户体验：显示加载状态，友好的错误提示

async function fetchUserData(userId) {
    const response = await fetch(`/api/users/${userId}`);
    return response.json();
}
```javascript

## 预期输出

```javascript
// 自定义错误类
class APIError extends Error {
    constructor(message, statusCode, details = null) {
        super(message);
        this.name = 'APIError';
        this.statusCode = statusCode;
        this.details = details;
        this.timestamp = new Date().toISOString();
    }

    toJSON() {
        return {
            name: this.name,
            message: this.message,
            statusCode: this.statusCode,
            details: this.details,
            timestamp: this.timestamp
        };
    }
}

// 重试工具函数
async function retryWithBackoff(fn, maxRetries = 3, baseDelay = 1000) {
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
            return await fn();
        } catch (error) {
            if (attempt === maxRetries) {
                throw error;
            }
            
            // 指数退避
            const delay = baseDelay * Math.pow(2, attempt - 1);
            await new Promise(resolve => setTimeout(resolve, delay));
        }
    }
}

// 带完整错误处理的用户数据获取函数
async function fetchUserData(userId, options = {}) {
    const {
        useCache = true,
        showLoading = true,
        onError = null,
        fallbackData = null
    } = options;

    // 显示加载状态
    if (showLoading && typeof showLoadingIndicator === 'function') {
        showLoadingIndicator(true);
    }

    try {
        // 检查缓存
        if (useCache) {
            const cachedData = getCachedUserData(userId);
            if (cachedData && !isCacheExpired(cachedData)) {
                return cachedData.data;
            }
        }

        // 带重试的API调用
        const userData = await retryWithBackoff(async () => {
            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), 10000); // 10秒超时

            try {
                const response = await fetch(`/api/users/${userId}`, {
                    signal: controller.signal,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                clearTimeout(timeoutId);

                if (!response.ok) {
                    switch (response.status) {
                        case 404:
                            throw new APIError(`用户 ${userId} 不存在`, 404);
                        case 403:
                            throw new APIError('没有权限访问该用户信息', 403);
                        case 429:
                            throw new APIError('请求过于频繁，请稍后再试', 429);
                        case 500:
                            throw new APIError('服务器内部错误', 500);
                        default:
                            throw new APIError(`请求失败: ${response.statusText}`, response.status);
                    }
                }

                const data = await response.json();
                
                // 缓存成功的响应
                if (useCache) {
                    cacheUserData(userId, data);
                }
                
                return data;

            } catch (error) {
                clearTimeout(timeoutId);
                
                if (error.name === 'AbortError') {
                    throw new APIError('请求超时，请检查网络连接', 408);
                }
                throw error;
            }
        }, 3, 1000);

        return userData;

    } catch (error) {
        // 记录错误日志
        console.error('[fetchUserData] Error:', {
            userId,
            error: error.toJSON ? error.toJSON() : error.message,
            stack: error.stack
        });

        // 尝试使用fallback数据
        if (fallbackData) {
            console.warn(`[fetchUserData] 使用fallback数据，用户ID: ${userId}`);
            return fallbackData;
        }

        // 尝试使用过期缓存
        if (useCache) {
            const expiredCache = getCachedUserData(userId);
            if (expiredCache) {
                console.warn(`[fetchUserData] 使用过期缓存数据，用户ID: ${userId}`);
                return expiredCache.data;
            }
        }

        // 调用自定义错误处理函数
        if (onError && typeof onError === 'function') {
            onError(error);
        }

        // 向用户显示友好的错误信息
        if (error instanceof APIError) {
            showUserFriendlyError(error.message);
        } else {
            showUserFriendlyError('获取用户数据时发生错误，请稍后重试');
        }

        throw error;

    } finally {
        // 隐藏加载状态
        if (showLoading && typeof showLoadingIndicator === 'function') {
            showLoadingIndicator(false);
        }
    }
}

// 辅助函数示例
function showUserFriendlyError(message) {
    // 实现用户友好的错误提示显示
    console.warn('User Error:', message);
}

function getCachedUserData(userId) {
    // 实现缓存获取逻辑
    return null;
}

function isCacheExpired(cachedData) {
    // 实现缓存过期检查
    return true;
}

function cacheUserData(userId, data) {
    // 实现数据缓存逻辑
}
```javascript

## 使用技巧

- 区分不同类型的错误并采用相应的处理策略
- 实现渐进式降级，提供fallback方案
- 记录详细的错误日志用于调试
- 向用户展示友好的错误信息，避免技术细节
- 考虑错误的传播和恢复机制

## 效果评估

**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接

- [[api-integration]]
- [[debugging-prompts]]
- [[unit-test-generation]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #error-handling #exception #robustness*
