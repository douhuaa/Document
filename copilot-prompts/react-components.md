# React 组件生成提示词

## 提示词类别
- [x] 代码生成
- [ ] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [ ] 文档生成
- [ ] 代码重构

## 应用场景
快速生成 React 组件模板、Hook 使用模式和组件间通信代码。

## 提示词内容

### 1. 功能组件模板
```
// 创建一个 React 功能组件 [组件名]
// Props: [列出需要的 props 及其类型]
// 状态管理: [使用的 Hook 类型]
// 功能: [组件的主要功能]
// 样式: [CSS模块/styled-components/className]
```

### 2. 自定义 Hook 模板
```
// 创建一个自定义 Hook use[HookName]
// 功能: [Hook 的具体功能]
// 输入参数: [参数类型和说明]
// 返回值: [返回的状态和方法]
// 副作用: [需要处理的副作用]
```

### 3. 表单组件模板
```
// 创建一个表单组件 [FormName]
// 字段: [列出表单字段]
// 验证规则: [各字段的验证要求]
// 提交处理: [表单提交后的处理逻辑]
// 错误处理: [表单验证错误的显示方式]
```

## 示例输入

```jsx
// 创建一个 React 功能组件 UserCard
// Props: user (object) - 包含 name, email, avatar 的用户对象
// 状态管理: 无需本地状态
// 功能: 显示用户信息，点击可展开详细信息
// 样式: 使用 CSS 模块
```

## 预期输出

```jsx
import React, { useState } from 'react';
import styles from './UserCard.module.css';

const UserCard = ({ user }) => {
    const [isExpanded, setIsExpanded] = useState(false);

    const handleToggleExpand = () => {
        setIsExpanded(!isExpanded);
    };

    return (
        <div className={styles.userCard} onClick={handleToggleExpand}>
            <div className={styles.userHeader}>
                <img 
                    src={user.avatar} 
                    alt={user.name}
                    className={styles.avatar}
                />
                <div className={styles.userInfo}>
                    <h3 className={styles.userName}>{user.name}</h3>
                    <p className={styles.userEmail}>{user.email}</p>
                </div>
            </div>
            
            {isExpanded && (
                <div className={styles.userDetails}>
                    {/* 额外的用户详细信息 */}
                </div>
            )}
        </div>
    );
};

export default UserCard;
```

## 使用技巧
- 明确指定组件的 props 类型和默认值
- 描述组件的交互行为和状态变化
- 指定使用的样式方案（CSS模块、styled-components等）
- 考虑组件的可访问性和响应式需求

## 效果评估
**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接
- [[code-generation-basics]]
- [[unit-test-generation]]
- [[css-utilities]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #react #frontend #components*