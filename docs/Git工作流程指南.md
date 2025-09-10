# Git 工作流程指南

## 🔄 基本工作流程

### 日常同步流程

```bash
# 1. 开始工作前 - 获取最新内容
git pull origin main

# 2. 编写笔记...

# 3. 检查更改
git status
git diff

# 4. 添加更改
git add .

# 5. 提交更改
git commit -m "feat: 添加机器学习项目笔记"

# 6. 推送到远程
git push origin main
```

### 快速同步 (使用脚本)
```bash
./scripts/sync-notes.sh
```

## 📝 提交信息规范

### 提交类型
- `feat:` - 新增内容/功能
- `docs:` - 文档更新
- `fix:` - 修复错误
- `refactor:` - 重构整理
- `style:` - 格式调整
- `chore:` - 杂项任务

### 示例
```bash
git commit -m "feat: 添加Python数据分析学习笔记"
git commit -m "docs: 更新项目README文档"
git commit -m "fix: 修正会议纪要中的错别字"
git commit -m "refactor: 重新组织项目文件结构"
```

## 🌿 分支管理策略

### 主分支工作流
```bash
# 适用于个人知识库
main (主分支) - 稳定版本
```

### 功能分支工作流
```bash
# 适用于团队协作或大型重构
main (主分支)
├── feature/new-template-system
├── feature/mobile-optimization  
└── hotfix/urgent-typo-fix
```

### 分支操作命令
```bash
# 创建并切换到新分支
git checkout -b feature/new-note-system

# 切换分支
git checkout main

# 合并分支
git merge feature/new-note-system

# 删除分支
git branch -d feature/new-note-system
```

## 🔧 常用命令速查

### 状态查看
```bash
# 查看工作区状态
git status

# 查看更改内容
git diff

# 查看暂存区内容
git diff --staged

# 查看提交历史
git log --oneline --graph
```

### 撤销操作
```bash
# 撤销工作区更改
git checkout -- filename.md

# 撤销暂存区更改
git reset HEAD filename.md

# 撤销最近一次提交 (保留更改)
git reset --soft HEAD~1

# 撤销最近一次提交 (丢弃更改)
git reset --hard HEAD~1
```

### 远程操作
```bash
# 查看远程仓库
git remote -v

# 添加远程仓库
git remote add origin https://github.com/username/repo.git

# 推送到远程
git push origin main

# 强制推送 (谨慎使用)
git push --force-with-lease origin main
```

## 🚫 .gitignore 最佳实践

### 当前配置说明
```gitignore
# Obsidian 临时文件
.obsidian/workspace*    # 工作区布局
.obsidian/cache/        # 缓存文件

# 系统文件
.DS_Store              # macOS
Thumbs.db             # Windows

# 敏感信息
private/              # 私人笔记
*.key                 # 密钥文件
```

### 根据需要调整
```bash
# 查看被忽略的文件
git status --ignored

# 强制添加被忽略的文件 (如果需要)
git add -f filename.md
```

## 🤝 团队协作流程

### Pull Request 工作流
```bash
# 1. 创建功能分支
git checkout -b feature/team-templates

# 2. 进行更改并提交
git add .
git commit -m "feat: 添加团队协作模板"

# 3. 推送分支
git push origin feature/team-templates

# 4. 在 GitHub 上创建 Pull Request
# 5. 代码审查和讨论
# 6. 合并到主分支
```

### 冲突解决
```bash
# 1. 拉取最新更改时发生冲突
git pull origin main

# 2. 查看冲突文件
git status

# 3. 手动编辑冲突文件
# 找到 <<<<<<< ======= >>>>>>> 标记
# 保留需要的内容，删除冲突标记

# 4. 标记冲突已解决
git add conflicted-file.md

# 5. 完成合并
git commit -m "resolve: 解决笔记合并冲突"
```

## 📱 多设备同步策略

### 设备配置建议
1. **主设备 (台式机/笔记本)**
   - 完整的开发环境
   - 负责主要的内容创建
   - 定期备份和维护

2. **移动设备 (手机/平板)**
   - Obsidian Mobile + Git 客户端
   - 快速笔记和查阅
   - 简单的编辑操作

3. **其他设备 (临时使用)**
   - GitHub Web 界面
   - 在线编辑器
   - 应急访问方案

### 同步频率建议
```bash
# 工作开始前
git pull origin main

# 工作过程中 (每小时或重要更改后)
./scripts/sync-notes.sh

# 工作结束后
./scripts/sync-notes.sh
```

## 🔒 数据安全与备份

### 自动化备份
```bash
# 设置定时备份 (添加到 crontab)
0 */6 * * * /path/to/vault/scripts/backup-vault.sh
```

### 多重备份策略
1. **Git 远程仓库** - 主要版本控制
2. **本地备份脚本** - 定期压缩备份
3. **云存储同步** - 额外保险 (Dropbox/OneDrive)
4. **移动设备备份** - 移动端本地缓存

### 恢复流程
```bash
# 从 Git 恢复
git clone https://github.com/username/knowledge-base.git

# 从备份文件恢复
tar -xzf backup_20240315_143000.tar.gz
```

## 📈 性能优化

### 大文件管理
```bash
# 使用 Git LFS 管理大文件
git lfs track "*.mp4"
git lfs track "*.pdf"
```

### 历史清理
```bash
# 查看仓库大小
du -sh .git

# 清理无用的引用
git gc --prune=now

# 查看大文件
git ls-files | xargs ls -lh | sort -k5 -hr | head -10
```

## 🛠️ 故障排除

### 常见问题及解决方案

#### 1. 推送被拒绝
```bash
# 错误: Updates were rejected
git pull --rebase origin main
git push origin main
```

#### 2. 分支落后于远程
```bash
git fetch origin
git merge origin/main
```

#### 3. 意外删除文件
```bash
# 从 Git 历史恢复
git checkout HEAD~1 -- deleted-file.md
```

#### 4. 提交信息写错
```bash
# 修改最后一次提交信息
git commit --amend -m "正确的提交信息"
```

### 紧急恢复指南
1. 不要慌张，Git 很难真正丢失数据
2. 使用 `git reflog` 查看所有操作历史
3. 从备份文件恢复重要内容
4. 寻求团队成员帮助