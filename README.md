# Obsidian 知识库 + Git 版本控制 + VS Code 增效工作流

一套完整的基于 Obsidian 的知识管理解决方案，结合 Git 进行版本控制和多端同步，使用 VS Code + GitHub Copilot 提高写作与整理效率。

## 🚀 快速开始

### 1. 环境准备

```bash
# 安装必需软件
# - Obsidian: https://obsidian.md/
# - VS Code: https://code.visualstudio.com/
# - Git: https://git-scm.com/

# 克隆此仓库作为你的知识库
git clone <your-repo-url> my-knowledge-base
cd my-knowledge-base
```

### 2. Obsidian 配置

```bash
# 启动 Obsidian 并选择此文件夹作为库
# 推荐插件会自动从 .obsidian/plugins/ 目录读取配置
```

### 3. VS Code 配置

```bash
# 在 VS Code 中打开工作区
code knowledge-base.code-workspace
```

## 📁 项目结构

```
📂 my-knowledge-base/
├── 📁 .obsidian/           # Obsidian 配置文件
│   ├── 📁 plugins/         # 插件配置
│   ├── 📁 snippets/        # CSS 代码片段
│   └── 📁 themes/          # 主题文件
├── 📁 .vscode/             # VS Code 工作区配置
├── 📁 templates/           # 笔记模板
├── 📁 attachments/         # 附件文件
├── 📁 daily-notes/         # 日记笔记
├── 📁 projects/            # 项目笔记
├── 📁 reference/           # 参考资料
├── 📁 scripts/             # 自动化脚本
└── 📄 README.md
```

## 🔧 推荐插件配置

### Obsidian 核心插件
- **Daily notes** - 日记功能
- **Templates** - 模板功能
- **Graph view** - 知识图谱
- **Backlinks** - 反向链接
- **Outline** - 大纲视图

### Obsidian 社区插件
- **Calendar** - 日历视图
- **Dataview** - 数据查询
- **Templater** - 高级模板
- **Advanced Tables** - 表格编辑
- **Excalidraw** - 手绘图表

### VS Code 扩展
- **GitHub Copilot** - AI 代码助手
- **Markdown All in One** - Markdown 增强
- **Paste Image** - 图片粘贴
- **GitLens** - Git 增强
- **Foam** - 知识管理

## 📝 使用指南

### 日常工作流程

```bash
# 1. 开始工作 - 拉取最新更改
git pull origin main

# 2. 在 Obsidian 或 VS Code 中编写笔记
# 使用模板快速创建标准化笔记

# 3. 提交更改
git add .
git commit -m "feat: 添加新的项目笔记"
git push origin main
```

### 多端同步策略

1. **主设备**（如台式机）：完整的 Obsidian + VS Code 环境
2. **移动设备**：Obsidian Mobile + Git 客户端
3. **其他设备**：通过 GitHub Web 界面快速编辑

## 🎯 最佳实践

### 1. 文件命名规范
- 使用有意义的文件名：`项目名-YYYY-MM-DD-主题.md`
- 避免空格，使用连字符：`machine-learning-notes.md`
- 使用标签进行分类：`#项目 #学习 #会议`

### 2. Git 提交规范
```bash
# 功能性更新
git commit -m "feat: 添加机器学习项目笔记"

# 内容更新  
git commit -m "docs: 更新API文档说明"

# 结构调整
git commit -m "refactor: 重组项目文件结构"
```

### 3. 模板使用
- 日记模板：`Ctrl+T` → 选择 "Daily Note"
- 项目模板：`Ctrl+T` → 选择 "Project Note"
- 会议模板：`Ctrl+T` → 选择 "Meeting Note"

## 🤖 GitHub Copilot 增效技巧

### VS Code 中的 Copilot 应用

1. **智能补全笔记内容**
```markdown
<!-- 输入注释，Copilot 会建议相关内容 -->
<!-- TODO: 分析机器学习模型性能 -->
```

2. **生成结构化内容**
```markdown
## 项目分析
<!-- Copilot 会建议项目分析的标准结构 -->
```

3. **代码示例生成**
```python
# 在代码块中，Copilot 可以生成示例代码
def analyze_data():
    # Copilot 会建议具体实现
```

## 📋 常用命令速查

### Git 操作
```bash
# 查看状态
git status

# 查看变更
git diff

# 恢复文件
git checkout -- filename.md

# 查看历史
git log --oneline --graph

# 创建分支（用于实验性笔记）
git checkout -b experiment/new-topic
```

### Obsidian 快捷键
- `Ctrl+N` - 新建笔记
- `Ctrl+O` - 快速打开
- `Ctrl+Shift+F` - 全局搜索
- `Ctrl+G` - 打开知识图谱
- `Ctrl+T` - 插入模板

### VS Code 快捷键
- `Ctrl+Shift+P` - 命令面板
- `Ctrl+K V` - 预览 Markdown
- `Alt+Shift+F` - 格式化文档
- `Ctrl+/` - 切换注释

## 🔄 自动化脚本

提供了多个自动化脚本来简化日常操作：

- `scripts/new-daily-note.sh` - 创建今日笔记
- `scripts/sync-notes.sh` - 快速同步笔记
- `scripts/backup-vault.sh` - 备份整个知识库
- `scripts/generate-index.sh` - 生成索引文件

## 📚 相关资源

- [Obsidian 官方文档](https://help.obsidian.md/)
- [VS Code Markdown 指南](https://code.visualstudio.com/docs/languages/markdown)
- [GitHub Copilot 使用技巧](https://docs.github.com/en/copilot)
- [Git 最佳实践](https://git-scm.com/doc)

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来改进这套工作流程！

## 📄 许可证

MIT License