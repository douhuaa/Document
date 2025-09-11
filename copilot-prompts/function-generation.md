# 函数生成专用提示词

## 提示词类别
- [x] 代码生成
- [ ] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [ ] 文档生成
- [ ] 代码重构

## 应用场景
专门用于生成各种类型的函数，包括工具函数、业务逻辑函数、异步函数等。

## 提示词内容

### 1. 通用函数生成模板
```
// 创建一个函数 ${函数名}
// 功能：${具体功能描述}
// 参数：${参数列表及类型}
// 返回值：${返回值类型和说明}
// 异常处理：${需要处理的异常情况}
// 性能要求：${如果有特殊性能要求}
```

### 2. 异步函数生成模板
```
// 创建一个异步函数 ${函数名}
// 功能：${异步操作描述}
// 参数：${参数说明}
// 返回值：Promise<${返回类型}>
// 错误处理：${如何处理异步错误}
// 超时处理：${是否需要超时控制}
```

### 3. 高阶函数生成模板
```
// 创建一个高阶函数 ${函数名}
// 功能：${接收函数并返回新函数}
// 输入函数类型：${输入函数的签名}
// 输出函数类型：${输出函数的签名}
// 装饰逻辑：${添加的功能描述}
```

## 示例输入

```javascript
// 创建一个函数 debounce
// 功能：防抖处理，延迟执行函数调用
// 参数：func (function) - 需要防抖的函数，delay (number) - 延迟时间（毫秒）
// 返回值：function - 防抖后的函数
// 异常处理：参数验证，确保func是函数，delay是正数
// 性能要求：内存占用最小化
```

## 预期输出

```javascript
function debounce(func, delay) {
    // 参数验证
    if (typeof func !== 'function') {
        throw new Error('First argument must be a function');
    }
    
    if (typeof delay !== 'number' || delay < 0) {
        throw new Error('Delay must be a non-negative number');
    }
    
    let timeoutId;
    
    return function debounced(...args) {
        // 清除之前的定时器
        if (timeoutId) {
            clearTimeout(timeoutId);
        }
        
        // 设置新的定时器
        timeoutId = setTimeout(() => {
            func.apply(this, args);
            timeoutId = null; // 释放引用以便垃圾回收
        }, delay);
    };
}
```

## 使用技巧
- 明确函数的单一职责原则
- 详细描述参数和返回值的类型
- 考虑边界情况和错误处理
- 对于复杂函数，可以分步骤描述实现逻辑
- 提及性能要求有助于生成更优化的代码

## 效果评估
**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接
- [[code-generation-basics]]
- [[error-handling]]
- [[performance-optimization]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #function-generation #javascript*