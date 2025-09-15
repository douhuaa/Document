# 单元测试生成提示词

## 提示词类别

- [ ] 代码生成
- [ ] 代码优化
- [ ] 代码解释
- [x] 测试生成
- [ ] 文档生成
- [ ] 代码重构

## 应用场景

为现有函数、类或模块快速生成全面的单元测试用例。

## 提示词内容

### 1. 基础测试生成

```javascript
// 为以下函数创建完整的单元测试
// 测试框架: [Jest/Mocha/pytest等]
// 需要测试的场景:
// - 正常情况
// - 边界条件
// - 异常情况
// - 输入验证

[贴入要测试的函数代码]
```javascript

### 2. 类方法测试

```javascript
// 为以下类创建单元测试套件
// 测试所有公共方法
// 包含mock外部依赖
// 验证状态变化和副作用

[贴入类定义代码]
```javascript

### 3. API 端点测试

```javascript
// 创建以下 API 端点的测试用例
// 端点: [HTTP方法] [路径]
// 测试场景:
// - 成功响应 (200)
// - 参数验证错误 (400)
// - 认证错误 (401)
// - 权限错误 (403)
// - 资源不存在 (404)
// - 服务器错误 (500)

[贴入路由处理器代码]
```javascript

## 示例输入

```javascript
// 为以下函数创建完整的单元测试
// 测试框架: Jest
// 需要测试的场景:
// - 正常情况
// - 边界条件  
// - 异常情况
// - 输入验证

function calculateDiscount(price, discountPercent, customerType) {
    if (typeof price !== 'number' || price < 0) {
        throw new Error('Price must be a positive number');
    }
    
    if (typeof discountPercent !== 'number' || discountPercent < 0 || discountPercent > 100) {
        throw new Error('Discount percent must be between 0 and 100');
    }
    
    let finalDiscount = discountPercent;
    
    if (customerType === 'premium') {
        finalDiscount += 5;
    } else if (customerType === 'vip') {
        finalDiscount += 10;
    }
    
    finalDiscount = Math.min(finalDiscount, 100);
    
    return price * (1 - finalDiscount / 100);
}
```javascript

## 预期输出

```javascript
describe('calculateDiscount', () => {
    describe('正常情况', () => {
        test('应该正确计算普通客户的折扣', () => {
            expect(calculateDiscount(100, 10, 'regular')).toBe(90);
        });

        test('应该正确计算高级客户的折扣', () => {
            expect(calculateDiscount(100, 10, 'premium')).toBe(85);
        });

        test('应该正确计算VIP客户的折扣', () => {
            expect(calculateDiscount(100, 10, 'vip')).toBe(80);
        });
    });

    describe('边界条件', () => {
        test('价格为0时应该返回0', () => {
            expect(calculateDiscount(0, 10, 'regular')).toBe(0);
        });

        test('折扣为0时应该返回原价', () => {
            expect(calculateDiscount(100, 0, 'regular')).toBe(100);
        });

        test('折扣达到100%时应该返回0', () => {
            expect(calculateDiscount(100, 100, 'regular')).toBe(0);
        });

        test('VIP客户总折扣不应超过100%', () => {
            expect(calculateDiscount(100, 95, 'vip')).toBe(0);
        });
    });

    describe('异常情况', () => {
        test('价格为负数时应该抛出错误', () => {
            expect(() => calculateDiscount(-10, 10, 'regular')).toThrow('Price must be a positive number');
        });

        test('价格不是数字时应该抛出错误', () => {
            expect(() => calculateDiscount('100', 10, 'regular')).toThrow('Price must be a positive number');
        });

        test('折扣百分比为负数时应该抛出错误', () => {
            expect(() => calculateDiscount(100, -5, 'regular')).toThrow('Discount percent must be between 0 and 100');
        });

        test('折扣百分比超过100时应该抛出错误', () => {
            expect(() => calculateDiscount(100, 105, 'regular')).toThrow('Discount percent must be between 0 and 100');
        });

        test('折扣百分比不是数字时应该抛出错误', () => {
            expect(() => calculateDiscount(100, '10', 'regular')).toThrow('Discount percent must be between 0 and 100');
        });
    });

    describe('客户类型处理', () => {
        test('未知客户类型应该按普通客户处理', () => {
            expect(calculateDiscount(100, 10, 'unknown')).toBe(90);
        });

        test('空客户类型应该按普通客户处理', () => {
            expect(calculateDiscount(100, 10, null)).toBe(90);
        });
    });
});
```javascript

## 使用技巧

- 明确指定要使用的测试框架
- 列出需要覆盖的测试场景类型
- 包含对外部依赖的mock说明
- 考虑异步函数的测试需求

## 效果评估

**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接

- [[code-generation-basics]]
- [[error-handling]]
- [[api-integration]]

---
*Created: 2025-09-10*  
*Tags: #copilot-prompt #testing #unit-tests #jest*
