# 完整的 Obsidian + Git + VS Code 知识库工作流（支持知识管理方法论）

一套完整的基于 Obsidian 的知识管理解决方案，整合了 Git 版本控制和 VS Code + GitHub Copilot 的智能写作功能，并新增了对主流知识管理方法论的全面支持，提供从配置到使用的全套解决方案。

## 🎯 主要特性

### 🔧 核心配置
- **Obsidian 完整配置**：包含核心插件、社区插件设置和工作区配置
- **VS Code 工作区**：针对 Markdown 写作优化的编辑环境  
- **GitHub Copilot 集成**：智能内容补全和写作辅助

### 📝 标准化模板
- 日记模板（Daily Notes）
- 项目笔记模板
- 会议纪要模板
- 学习笔记模板

### 🧠 知识管理方法论支持
- **常青笔记 (Evergreen Notes)**：原子化概念笔记系统，支持持续发展的知识体系
- **内容地图 (MOC - Maps of Content)**：结构化知识导航和索引系统  
- **卢曼卡片盒法 (Zettelkasten)**：基于连接的思想网络，支持独特编号系统

### 🤖 自动化脚本
- `new-daily-note.sh` - 快速创建日记
- `sync-notes.sh` - 一键同步笔记
- `backup-vault.sh` - 自动备份知识库
- `generate-index.sh` - 生成知识库索引

### 📚 完整文档
- 快速入门指南 - 5分钟搭建完整环境
- 知识管理方法论指南 - Evergreen、MOC、Zettelkasten 详解及 GitHub Copilot 提示词
- GitHub Copilot 使用技巧 - 提升写作效率的实用方法
- Git 工作流程指南 - 版本控制和多端同步最佳实践

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

### 4. 开始使用知识管理方法论

```bash
# 创建第一篇常青笔记
# 在 VS Code 中输入 "evergreen" 然后按 Tab

# 创建内容地图
# 在 VS Code 中输入 "moc" 然后按 Tab

# 创建卢曼卡片盒笔记  
# 在 VS Code 中输入 "zettel" 然后按 Tab

# 快速创建日记
./scripts/new-daily-note.sh

# 同步笔记到云端
./scripts/sync-notes.sh
```

> 📖 **详细教程**: 查看 [快速入门指南](docs/快速入门指南.md) 获取完整的5分钟设置教程

## 📁 项目结构

```
📂 Knowledge Base/
├── 📁 .obsidian/           # Obsidian 配置文件
│   ├── 📁 plugins/         # 插件配置
│   ├── 📁 snippets/        # CSS 代码片段
│   └── 📁 themes/          # 主题文件
├── 📁 .vscode/             # VS Code 工作区设置
├── 📁 templates/           # 笔记模板集合
│   ├── daily-note-template.md
│   ├── evergreen-note-template.md    # 🌱 常青笔记模板
│   ├── moc-template.md              # 🗺️ 内容地图模板
│   ├── zettelkasten-note-template.md # 🗃️ 卢曼卡片盒模板
│   ├── project-note-template.md
│   ├── meeting-note-template.md
│   └── learning-note-template.md
├── 📁 scripts/             # 自动化脚本
│   ├── new-daily-note.sh   # 创建日记
│   ├── sync-notes.sh       # 同步笔记
│   ├── backup-vault.sh     # 备份知识库
│   └── generate-index.sh   # 生成索引
├── 📁 docs/                # 使用文档
│   ├── 快速入门指南.md
│   ├── 知识管理方法论指南.md
│   ├── GitHub-Copilot使用技巧.md
│   ├── Git工作流程指南.md
│   └── 知识库索引.md
├── 📁 daily-notes/         # 日记笔记
├── 📁 projects/            # 项目笔记
├── 📁 attachments/         # 附件文件
├── 📄 knowledge-base.code-workspace  # VS Code 工作区配置
└── 📄 README.md
```

## 🧠 知识管理方法论

本解决方案支持三种主流的知识管理方法论，每种都有其独特的应用场景：

### 🌱 常青笔记 (Evergreen Notes)
**适用场景**: 深度学习、概念理解、长期知识积累

**核心特点**:
- 原子化：一个笔记只讨论一个核心概念
- 概念导向：围绕概念而非事件组织
- 密集链接：与其他笔记广泛连接
- 持续发展：像常青树一样不断成长

**快速创建**: 在 VS Code 中输入 `evergreen` + Tab

### 🗺️ 内容地图 (Maps of Content - MOC)  
**适用场景**: 学科整理、主题导航、知识体系梳理

**核心特点**:
- 结构化组织：为相关笔记提供层次结构
- 导航指引：快速定位所需信息
- 知识概览：鸟瞰特定领域的全貌
- 学习路径：规划学习和探索路线

**快速创建**: 在 VS Code 中输入 `moc` + Tab

### 🗃️ 卢曼卡片盒法 (Zettelkasten)
**适用场景**: 创意思考、研究写作、跨领域连接

**核心特点**:
- 独特编号：每个笔记都有唯一的时间戳编号
- 思想网络：通过关联建立思想的网状结构  
- 原子化思考：每张卡片一个想法
- 涌现智慧：通过连接产生新的洞察

**快速创建**: 在 VS Code 中输入 `zettel` + Tab

> 📚 **详细指南**: 查看 [知识管理方法论指南](docs/知识管理方法论指南.md) 了解每种方法的详细使用方法和 GitHub Copilot 提示词

## 🔧 核心配置

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

### 代码片段支持
本解决方案为 VS Code 提供了专门的代码片段，支持快速创建各种类型的笔记：

- `evergreen` - 创建常青笔记
- `moc` - 创建内容地图
- `zettel` - 创建卢曼卡片盒笔记
- `daily` - 创建日记模板
- `project` - 创建项目笔记
- `meeting` - 创建会议纪要

## 📝 日常使用工作流

### 智能写作流程

```bash
# 1. 开始工作 - 拉取最新更改
git pull origin main

# 2. 根据需求选择合适的笔记类型：
#    - 学习新概念 → 常青笔记 (evergreen)
#    - 整理主题知识 → 内容地图 (moc) 
#    - 记录想法灵感 → 卢曼卡片盒 (zettel)
#    - 日常记录 → 日记 (daily)

# 3. 在 VS Code 中使用 GitHub Copilot 辅助写作

# 4. 在 Obsidian 中查看知识图谱和建立连接

# 5. 使用自动化脚本同步
./scripts/sync-notes.sh
```

### 多端同步策略

1. **主设备**（台式机/笔记本）：完整的 Obsidian + VS Code + GitHub Copilot 环境
2. **移动设备**：Obsidian Mobile + Git 客户端
3. **其他设备**：通过 GitHub Web 界面快速编辑
4. **团队协作**：通过 Git 分支进行协同编辑

### 自动化脚本使用

```bash
# 快速创建今日笔记
./scripts/new-daily-note.sh

# 一键同步笔记到云端
./scripts/sync-notes.sh

# 备份整个知识库
./scripts/backup-vault.sh

# 生成知识库索引
./scripts/generate-index.sh
```

## 🎯 使用场景

### 个人知识管理
- **深度学习研究**: 使用常青笔记构建概念体系，通过 MOC 组织学科知识
- **创意思考发展**: 利用 Zettelkasten 发展思想网络和跨领域连接
- **项目知识沉淀**: 统一管理项目记录、会议纪要、学习心得

### 团队协作应用  
- **知识库建设**: 通过 Git 实现团队知识的版本控制和协同编辑
- **研究协作**: 多人共同维护和发展某个研究主题的知识体系
- **培训体系**: 建立系统化的培训材料和学习路径

### 多端同步场景
- **移动记录**: 随时在手机上记录想法，自动同步到主知识库
- **跨设备工作**: 在不同设备间无缝切换，保持知识工作的连续性
- **远程协作**: 支持分布式团队的知识共享和协同创作

### 智能写作增效
- **内容创作**: 利用 GitHub Copilot 和专业提示词提升写作效率
- **知识整理**: AI 辅助进行知识分类、总结和结构化组织
- **学习辅助**: 智能生成学习大纲、知识点总结和复习材料

## 🤖 GitHub Copilot 增效技巧

### 知识管理中的 AI 辅助写作

#### 🌱 常青笔记写作提示词
```
请帮我将以下信息转化为一个常青笔记：
- 核心概念：[概念名称]
- 详细内容：[详细描述]
- 相关链接：[已有的相关笔记]

要求：
1. 保持原子化，只讨论一个核心概念
2. 用清晰、简洁的语言解释
3. 建立与其他概念的连接
4. 包含我的个人思考和见解
```

#### 🗺️ 内容地图整理提示词
```
请帮我为 [主题名称] 创建一个内容地图(MOC)：
- 包含的子主题：[列出相关主题]
- 目标受众：[初学者/进阶者/专家]
- 学习目标：[希望达成的目标]

要求：
1. 创建清晰的主题层次结构
2. 规划合理的学习路径
3. 推荐重要的学习资源
4. 标明知识点的难度级别
```

#### 🗃️ 卢曼卡片盒思考提示词
```
帮我深入分析这个想法并创建卢曼卡片：
- 核心想法：[描述想法]
- 触发来源：[书籍/文章/对话/思考]
- 相关领域：[涉及的学科或主题]

要求：
1. 提取想法的本质和核心观点
2. 分析与其他概念的潜在连接
3. 提出可能的应用场景
4. 生成进一步思考的问题
```

### VS Code 中的智能写作技巧

1. **结构化内容生成**
```markdown
## 学习笔记：机器学习
<!-- Copilot 会建议完整的学习笔记结构 -->
```

2. **代码示例自动生成**  
```python
# 在代码块中，Copilot 可以生成相关的示例代码
def knowledge_graph_analysis():
    # Copilot 会建议具体实现
```

3. **智能内容补全**
   - 输入关键概念，Copilot 自动补全详细解释
   - 创建列表时，Copilot 建议相关条目
   - 写作总结时，Copilot 提供结构化框架

> 📚 **详细技巧**: 查看 [GitHub Copilot使用技巧](docs/GitHub-Copilot使用技巧.md) 了解更多实用方法

## 🎯 最佳实践

### 1. 文件命名规范
- **常青笔记**: 概念名称，如 `机器学习中的过拟合.md`
- **内容地图**: 主题+MOC，如 `Python编程-MOC.md`
- **卢曼卡片**: 时间戳编号，如 `202312151430-深度学习的本质.md`
- **项目笔记**: `项目名-YYYY-MM-DD-主题.md`
- **日记**: `YYYY-MM-DD.md`

### 2. Git 提交规范
```bash
# 新增内容
git commit -m "feat: 添加机器学习项目笔记"

# 更新现有内容
git commit -m "docs: 更新API文档说明"

# 结构调整
git commit -m "refactor: 重组项目文件结构"

# 新增知识管理内容
git commit -m "feat: 新增深度学习常青笔记"
git commit -m "feat: 创建Python学习MOC"
git commit -m "feat: 添加创新思考卢曼卡片"
```

### 3. 模板使用策略
- **VS Code 快捷方式**: 使用代码片段快速创建（`evergreen` + Tab）
- **Obsidian 模板**: 使用 `Ctrl+T` 选择模板
- **自动化脚本**: 使用 `./scripts/new-daily-note.sh` 创建日记

### 4. 知识连接建议
- **常青笔记**: 重点建立概念之间的逻辑连接
- **MOC**: 作为知识导航中心，连接相关主题
- **Zettelkasten**: 鼓励跨领域的意外连接和创新思考

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

## 📚 完整文档资源

### 📖 使用指南  
- [快速入门指南](docs/快速入门指南.md) - 5分钟搭建完整环境
- [知识管理方法论指南](docs/知识管理方法论指南.md) - Evergreen、MOC、Zettelkasten 详解
- [GitHub Copilot使用技巧](docs/GitHub-Copilot使用技巧.md) - 提升写作效率的实用方法
- [Git工作流程指南](docs/Git工作流程指南.md) - 版本控制和多端同步最佳实践
- [知识库索引](docs/知识库索引.md) - 完整的知识库导航

### 🌐 官方资源
- [Obsidian 官方文档](https://help.obsidian.md/)
- [VS Code Markdown 指南](https://code.visualstudio.com/docs/languages/markdown)  
- [GitHub Copilot 官方文档](https://docs.github.com/en/copilot)
- [Git 最佳实践](https://git-scm.com/doc)

### 📝 方法论参考
- [Andy Matuschak - Evergreen Notes](https://notes.andymatuschak.org/Evergreen_notes)
- [Nick Milo - Maps of Content](https://www.linkingyourthinking.com/)
- [Zettelkasten Method](https://zettelkasten.de/introduction/)

## 💡 技术架构

```
Obsidian (笔记编写) → Git (版本控制) → GitHub (远程同步)
    ↕                      ↕
VS Code + Copilot (智能编辑)  ←→  多端设备同步
    ↕
知识管理方法论模板 (Evergreen/MOC/Zettelkasten)
```

## 🚀 优势特性

- **版本控制**: 完整的笔记历史记录和变更追踪
- **多端同步**: 基于 Git 的可靠同步机制
- **智能辅助**: GitHub Copilot 提供内容建议和结构优化
- **专业方法论**: 支持业界主流的知识管理理论和实践
- **标准化流程**: 统一的模板和工作流程提高效率
- **自动化工具**: 减少重复操作，专注内容创作

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来改进这套工作流程！

## 📄 许可证

MIT License