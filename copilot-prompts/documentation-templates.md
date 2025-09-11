# 文档生成模板提示词

## 提示词类别
- [ ] 代码生成
- [ ] 代码优化
- [ ] 代码解释
- [ ] 测试生成
- [x] 文档生成
- [ ] 代码重构

## 应用场景
用于生成项目文档、API文档、代码注释、用户手册等各种类型的技术文档。

## 提示词内容

### 1. API文档生成
```
// 为以下API端点生成完整的文档
// 端点信息：${HTTP方法} ${路径}
// 功能描述：${端点的主要功能}
// 认证方式：${需要的认证信息}
// 请求参数：${参数列表、类型、是否必需}
// 响应格式：${成功和错误响应的格式}
// 示例代码：${请求和响应示例}
// 错误码说明：${可能的错误码及其含义}

${贴入API代码或路由定义}
```

### 2. 函数/类文档生成
```
// 为以下代码生成详细的文档注释
// 注释风格：${JSDoc/PyDoc/GoDoc等}
// 包含内容：功能描述、参数说明、返回值、异常、示例
// 复杂度分析：${时间复杂度和空间复杂度}
// 使用场景：${何时使用该函数/类}
// 注意事项：${使用时需要注意的问题}

${贴入需要文档化的代码}
```

### 3. 项目README生成
```
// 为项目生成README文档
// 项目类型：${Web应用/库/工具/API等}
// 技术栈：${使用的主要技术和框架}
// 功能特性：${项目的核心功能}
// 安装部署：${环境要求和安装步骤}
// 使用指南：${基本使用方法和示例}
// 贡献指南：${如何参与项目开发}
// 许可证：${开源许可证类型}
```

## 示例输入

```javascript
// 为以下API端点生成完整的文档
// 端点信息：POST /api/users
// 功能描述：创建新用户账户
// 认证方式：Bearer Token（管理员权限）
// 请求参数：用户信息（姓名、邮箱、角色等）
// 响应格式：创建成功返回用户信息，失败返回错误详情
// 示例代码：包含curl和JavaScript调用示例
// 错误码说明：400、401、403、409、500等错误情况

app.post('/api/users', authenticateAdmin, async (req, res) => {
    try {
        const { name, email, role, department } = req.body;
        
        // 验证输入
        if (!name || !email) {
            return res.status(400).json({ error: '姓名和邮箱为必填项' });
        }
        
        // 检查邮箱是否已存在
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(409).json({ error: '该邮箱已被注册' });
        }
        
        // 创建用户
        const user = new User({
            name,
            email,
            role: role || 'user',
            department,
            createdAt: new Date()
        });
        
        await user.save();
        
        res.status(201).json({
            message: '用户创建成功',
            user: {
                id: user._id,
                name: user.name,
                email: user.email,
                role: user.role,
                department: user.department,
                createdAt: user.createdAt
            }
        });
        
    } catch (error) {
        console.error('创建用户失败:', error);
        res.status(500).json({ error: '服务器内部错误' });
    }
});
```

## 预期输出

```markdown
# 创建新用户 API

## 基本信息

- **端点**: `POST /api/users`
- **功能**: 创建新用户账户
- **权限**: 需要管理员权限
- **认证**: Bearer Token

## 请求格式

### 请求头
```http
POST /api/users HTTP/1.1
Host: api.example.com
Content-Type: application/json
Authorization: Bearer {admin_token}
```

### 请求参数

| 参数名 | 类型 | 必需 | 描述 | 示例 |
|--------|------|------|------|------|
| name | string | ✅ | 用户姓名 | "张三" |
| email | string | ✅ | 用户邮箱 | "zhangsan@example.com" |
| role | string | ❌ | 用户角色，默认为 "user" | "admin", "user", "viewer" |
| department | string | ❌ | 所属部门 | "技术部" |

### 请求体示例
```json
{
  "name": "张三",
  "email": "zhangsan@example.com",
  "role": "user",
  "department": "技术部"
}
```

## 响应格式

### 成功响应 (201 Created)
```json
{
  "message": "用户创建成功",
  "user": {
    "id": "64f1a2b3c4d5e6f7g8h9i0j1",
    "name": "张三",
    "email": "zhangsan@example.com",
    "role": "user",
    "department": "技术部",
    "createdAt": "2024-01-20T10:30:00.000Z"
  }
}
```

## 错误响应

### 400 Bad Request - 参数错误
```json
{
  "error": "姓名和邮箱为必填项"
}
```

### 401 Unauthorized - 未认证
```json
{
  "error": "未提供有效的认证令牌"
}
```

### 403 Forbidden - 权限不足
```json
{
  "error": "需要管理员权限"
}
```

### 409 Conflict - 邮箱已存在
```json
{
  "error": "该邮箱已被注册"
}
```

### 500 Internal Server Error - 服务器错误
```json
{
  "error": "服务器内部错误"
}
```

## 代码示例

### cURL
```bash
curl -X POST "https://api.example.com/api/users" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ADMIN_TOKEN" \
  -d '{
    "name": "张三",
    "email": "zhangsan@example.com",
    "role": "user",
    "department": "技术部"
  }'
```

### JavaScript (fetch)
```javascript
async function createUser(userData, adminToken) {
  try {
    const response = await fetch('https://api.example.com/api/users', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${adminToken}`
      },
      body: JSON.stringify(userData)
    });
    
    const result = await response.json();
    
    if (!response.ok) {
      throw new Error(result.error || '创建用户失败');
    }
    
    return result;
  } catch (error) {
    console.error('创建用户失败:', error.message);
    throw error;
  }
}

// 使用示例
const newUser = {
  name: "张三",
  email: "zhangsan@example.com",
  role: "user",
  department: "技术部"
};

createUser(newUser, 'your_admin_token_here')
  .then(result => console.log('用户创建成功:', result))
  .catch(error => console.error('错误:', error.message));
```

### Python (requests)
```python
import requests

def create_user(user_data, admin_token):
    url = "https://api.example.com/api/users"
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {admin_token}"
    }
    
    response = requests.post(url, json=user_data, headers=headers)
    
    if response.status_code == 201:
        return response.json()
    else:
        error_msg = response.json().get('error', '创建用户失败')
        raise Exception(f"HTTP {response.status_code}: {error_msg}")

# 使用示例
user_data = {
    "name": "张三",
    "email": "zhangsan@example.com",
    "role": "user",
    "department": "技术部"
}

try:
    result = create_user(user_data, "your_admin_token_here")
    print("用户创建成功:", result)
except Exception as e:
    print("错误:", str(e))
```

## 业务逻辑

1. **输入验证**: 检查必需字段（姓名、邮箱）是否提供
2. **唯一性检查**: 验证邮箱地址是否已经被注册
3. **权限验证**: 确保请求者具有管理员权限
4. **数据创建**: 在数据库中创建新用户记录
5. **响应返回**: 返回创建的用户信息（不包含敏感数据）

## 注意事项

- 邮箱地址将作为用户的唯一标识符
- 用户角色默认为 "user"，可选值包括 "admin", "user", "viewer"
- 创建时间自动设置为当前时间戳
- 响应中不包含密码等敏感信息
- 建议在生产环境中添加邮箱格式验证和防暴力破解机制

## 相关端点

- [获取用户列表](./get-users.md) - `GET /api/users`
- [获取用户详情](./get-user.md) - `GET /api/users/:id`
- [更新用户信息](./update-user.md) - `PUT /api/users/:id`
- [删除用户](./delete-user.md) - `DELETE /api/users/:id`
```

## 使用技巧
- 明确文档的目标读者（开发者、最终用户、运维等）
- 提供完整的示例代码和使用场景
- 包含错误处理和边界情况说明
- 使用清晰的结构和格式化
- 定期更新文档以保持与代码同步

## 效果评估
**准确性**: ⭐⭐⭐⭐⭐  
**实用性**: ⭐⭐⭐⭐⭐  
**创新性**: ⭐⭐⭐⭐⭐  

## 相关链接
- [[api-integration]]
- [[code-comments]]
- [[rest-api-design]]

---
*Created: 2024-01-20*  
*Tags: #copilot-prompt #documentation #api-docs #technical-writing*