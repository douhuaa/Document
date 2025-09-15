# 基础代码生成提示词

## 提示词类别

- [x] 代码生成
- [ ] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [ ] 文档生成
- [ ] 代码重构

## 应用场景

当需要快速生成基础的代码结构、函数框架或常用代码模式时使用。

## 提示词内容

### 1. 函数生成基础模板

```javascript
// 创建一个函数来 [具体功能描述]
// 输入参数: [参数类型和说明]
// 返回值: [返回值类型和说明]
// 需要处理的边界情况: [列出边界情况]
```javascript

### 2. 类生成模板

```javascript
// 创建一个 [类名] 类
// 功能: [类的主要功能]
// 属性: [列出需要的属性]
// 方法: [列出需要的方法]
// 设计模式: [如果需要特定模式]
```javascript

### 3. 数据处理模板

```javascript
// 处理以下数据结构: [描述输入数据格式]
// 转换为: [描述输出数据格式]
// 处理逻辑: [具体的转换规则]
// 错误处理: [如何处理异常情况]
```javascript

## 示例输入

```javascript
// 创建一个函数来计算数组中所有数字的平均值
// 输入参数: numbers (number[]) - 数字数组
// 返回值: number - 平均值
// 需要处理的边界情况: 空数组、非数字元素
```javascript

## 预期输出

```javascript
function calculateAverage(numbers) {
    if (!Array.isArray(numbers) || numbers.length === 0) {
        throw new Error('Input must be a non-empty array');
    }
    
    const validNumbers = numbers.filter(num => typeof num === 'number' && !isNaN(num));
    
    if (validNumbers.length === 0) {
        throw new Error('Array must contain at least one valid number');
    }
    
    const sum = validNumbers.reduce((acc, num) => acc + num, 0);
    return sum / validNumbers.length;
}
```javascript

## 使用技巧

- 在注释中清楚描述函数的目的和期望行为
- 明确指定输入输出的数据类型
- 列出需要考虑的边界情况和错误处理
- 使用具体的业务术语而不是抽象概念

## 效果评估

**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接

- [[function-generation]]
- [[error-handling]]
- [[code-comments]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #code-generation #basics*
