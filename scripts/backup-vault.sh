#!/bin/bash
# 备份整个知识库脚本

# 配置
BACKUP_DIR="$HOME/obsidian-backups"
VAULT_NAME=$(basename "$(pwd)")
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="${VAULT_NAME}_${TIMESTAMP}"

echo "🗂️  开始备份知识库..."

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 创建压缩备份
echo "📦 创建压缩备份..."
if tar -czf "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" \
    --exclude='.git' \
    --exclude='.obsidian/workspace*' \
    --exclude='.obsidian/cache' \
    --exclude='node_modules' \
    --exclude='.DS_Store' \
    .; then
    
    echo "✅ 备份创建成功: ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz"
    
    # 显示备份大小
    BACKUP_SIZE=$(du -h "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" | cut -f1)
    echo "📊 备份大小: $BACKUP_SIZE"
    
    # 清理旧备份 (保留最近10个)
    echo "🧹 清理旧备份..."
    cd "$BACKUP_DIR" || exit 1
    ls -t ${VAULT_NAME}_*.tar.gz | tail -n +11 | xargs -r rm
    
    BACKUP_COUNT=$(ls -1 ${VAULT_NAME}_*.tar.gz 2>/dev/null | wc -l)
    echo "📚 当前备份数量: $BACKUP_COUNT"
    
else
    echo "❌ 备份创建失败"
    exit 1
fi

# 如果配置了云存储，可以在这里添加上传逻辑
# 例如上传到 Google Drive, Dropbox 等

echo "🎉 备份完成！"