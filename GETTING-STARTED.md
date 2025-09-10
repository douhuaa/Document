# 快速开始指南

## 🎯 5分钟设置指南

### 第1步：安装必要扩展
1. 打开 VS Code
2. 按 `Ctrl+Shift+X` 打开扩展市场
3. 搜索并安装以下扩展：
   - **Foam** by Foam
   - **GitHub Copilot** by GitHub  
   - **GitHub Copilot Chat** by GitHub
   - **Markdown All in One** by Yu Zhang

### 第2步：克隆或下载知识库
```bash
git clone [your-repo-url]
cd Document
code .
```

### 第3步：验证设置
1. 打开 VS Code 命令面板 (`Ctrl+Shift+P`)
2. 输入 "Foam" 应该看到相关命令
3. 尝试 "Foam: Show Graph" 查看知识图谱

## 🚀 第一次使用

### 创建你的第一个笔记
1. 按 `Ctrl+Shift+P`
2. 选择 "Foam: Create New Note"
3. 选择模板或直接输入文件名
4. 开始写作！

### 使用双向链接
- 输入 `[[` 然后输入笔记名称
- 如果笔记不存在，Foam 会创建一个占位符
- 点击链接可以快速导航

### 每日笔记工作流
1. 使用 "Foam: Open Daily Note" 命令
2. 或者手动创建：`daily-notes/YYYY-MM-DD.md`
3. 使用提供的模板开始记录

## 🤖 Copilot 提示词使用

### 基础用法
1. 浏览 [[copilot-prompts/README]] 查看可用提示词
2. 复制感兴趣的提示词到你的编辑器
3. 根据需要修改参数和上下文
4. 让 Copilot 生成代码

### 示例工作流
```javascript
// 1. 复制提示词模板
// 创建一个函数来 [具体功能描述]
// 输入参数: [参数类型和说明]
// 返回值: [返回值类型和说明]

// 2. 填入具体需求
// 创建一个函数来验证邮箱地址格式
// 输入参数: email (string) - 待验证的邮箱地址
// 返回值: boolean - 邮箱格式是否正确

// 3. 让 Copilot 生成代码（通常会自动开始）
```

## 📂 组织你的内容

### 推荐的内容分类
- **daily-notes/**: 每日记录和反思
- **areas/**: 长期关注的知识领域
- **projects/**: 具体项目的笔记和文档
- **resources/**: 参考资料和外部链接
- **copilot-prompts/**: Copilot 提示词收藏

### 标签使用建议
- `#learning` - 学习笔记
- `#project-[name]` - 特定项目
- `#copilot-prompt` - 提示词相关
- `#daily-note` - 每日笔记
- `#idea` - 想法和灵感

## ⚡ 高效使用技巧

### Foam 快捷键
- `[[` - 创建/链接笔记
- `Ctrl+Click` - 跟随链接
- `Alt+Click` - 在侧边栏打开链接

### VS Code 优化
- 使用 `Ctrl+Shift+F` 全局搜索
- `Ctrl+T` 快速打开文件
- `Ctrl+Shift+P` 命令面板

### Copilot 最佳实践
1. **提供充足上下文**: 在代码文件中包含相关导入和类型定义
2. **使用描述性注释**: 清楚说明你想要实现的功能
3. **迭代优化**: 如果第一次结果不理想，尝试重新表述

## 🔧 自定义配置

### 修改设置
编辑 `.vscode/settings.json` 来调整：
- Foam 行为设置
- Markdown 预览样式
- 文件关联规则

### 创建新模板
1. 在 `templates/` 目录创建新的 `.md` 文件
2. 使用 Foam 变量如 `${FOAM_TITLE}`, `${FOAM_DATE}`
3. 在创建笔记时选择你的模板

## 🎓 进阶使用

### 构建知识图谱
- 定期使用 "Foam: Show Graph" 审查知识结构
- 识别孤立的笔记并建立连接
- 使用标签创建主题集群

### Copilot 进阶技巧
- 学习不同编程语言的提示词模式
- 创建项目特定的提示词模板  
- 实验复杂的多步骤生成任务

### 数据导入导出
- 使用 Markdown 格式便于迁移
- 定期备份整个知识库
- 考虑使用 Git 进行版本控制

## 🆘 常见问题

**Q: 双向链接不工作？**
A: 确保安装了 Foam 扩展并重启 VS Code

**Q: Copilot 建议质量不高？**
A: 尝试提供更多上下文，使用更具体的注释

**Q: 图谱视图显示空白？**
A: 创建一些包含链接的笔记，图谱需要链接关系才能显示

**Q: 模板变量不替换？**
A: 检查模板语法，确保使用正确的 Foam 变量格式

## 📚 学习资源

- [Foam 官方文档](https://foambubble.github.io/foam/)
- [GitHub Copilot 文档](https://docs.github.com/en/copilot)
- [Markdown 语法指南](https://www.markdownguide.org/basic-syntax/)
- [知识管理最佳实践](https://en.wikipedia.org/wiki/Personal_knowledge_management)

---

准备好开始你的知识管理之旅了吗？从创建你的第一个每日笔记开始吧！

*Tags: #getting-started #tutorial #foam #knowledge-management*