# 个人知识库 - Foam + GitHub Copilot

欢迎来到基于 Foam for VS Code 和 GitHub Copilot 的个人知识管理系统！

## 🚀 快速开始

### 1. 安装必要扩展

在 VS Code 中安装以下扩展（已在 `.vscode/extensions.json` 中配置）：

- Foam
- GitHub Copilot
- GitHub Copilot Chat
- Markdown All in One

### 2. 打开知识库

使用 VS Code 打开此文件夹，Foam 会自动识别并激活相关功能。

### 3. 开始使用

- 按 `Ctrl+Shift+P` 打开命令面板
- 输入 "Foam" 查看可用命令
- 使用 `Foam: Create New Note` 创建新笔记

## 📁 文件夹结构

```text
├── 📁 daily-notes/          # 每日笔记
├── 📁 templates/            # 笔记模板
├── 📁 copilot-prompts/      # Copilot 提示词库
├── 📁 areas/                # 知识领域
├── 📁 projects/             # 项目笔记
├── 📁 resources/            # 参考资源
├── 📁 inbox/                # 待整理内容
├── 📁 attachments/          # 附件文件
└── 📁 .vscode/              # VS Code 配置
```javascript

## 🎯 主要功能

### 📝 笔记管理

- **双向链接**: 使用 `[[笔记名]]` 创建笔记间的链接
- **标签系统**: 使用 `#标签名` 组织内容
- **图谱视图**: 可视化笔记间的关系网络
- **每日笔记**: 快速记录每天的想法和学习

### 🤖 Copilot 集成

- **提示词库**: 精选的 GitHub Copilot 提示词集合
- **代码生成**: 高效的编程模式和代码模板
- **最佳实践**: 经过验证的 Copilot 使用技巧

## 🛠️ 使用指南

### 创建新笔记

1. 使用模板快速开始：
   - [[templates/daily-note]] - 每日笔记模板
   - [[templates/project-note]] - 项目笔记模板
   - [[templates/learning-note]] - 学习笔记模板
   - [[templates/copilot-prompt]] - Copilot 提示词模板

2. 或直接创建链接： `[[新笔记名称]]`

### Copilot 提示词库

访问 [[copilot-prompts/README]] 查看完整的提示词集合，包括：

- 代码生成基础模板
- React 组件生成
- 测试用例生成
- 文档生成助手

### 每日工作流程

1. 打开今天的每日笔记：`Foam: Open Daily Note`
2. 记录学习内容和代码片段
3. 实验新的 Copilot 提示词
4. 链接到相关的项目和学习笔记

## 🔗 快速导航

### 核心区域

- [[areas/]] - 知识领域导航
- [[projects/]] - 项目管理
- [[copilot-prompts/]] - Copilot 提示词库

### 今日快捷方式

- [[daily-notes/]] - 每日笔记存档
- [[inbox/]] - 待整理内容

## ⚙️ 自定义配置

知识库已预配置最佳设置，包括：

- Foam 工作区优化
- 图谱可视化设置
- 文件关联和搜索优化
- Copilot 集成配置

如需自定义，请编辑 `.vscode/settings.json` 文件。

## 🎓 学习资源

- [Foam 官方文档](https://foambubble.github.io/foam/)
- [GitHub Copilot 使用指南](https://docs.github.com/en/copilot)
- [Markdown 语法参考](https://www.markdownguide.org/)

---

*最后更新：2024-01-20*  
*标签：#知识管理 #foam #copilot #文档*
