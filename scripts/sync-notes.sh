#!/bin/bash
# 快速同步笔记脚本

echo "🔄 开始同步笔记..."

# 检查是否在 Git 仓库中
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ 错误: 当前目录不是 Git 仓库"
    exit 1
fi

# 拉取远程更改
echo "📥 拉取远程更改..."
if git pull origin main; then
    echo "✅ 远程更改拉取成功"
else
    echo "⚠️  拉取过程中出现问题，请检查网络连接或解决冲突"
    exit 1
fi

# 检查是否有本地更改
if git diff-index --quiet HEAD --; then
    echo "ℹ️  没有本地更改需要提交"
else
    echo "📝 发现本地更改，准备提交..."
    
    # 显示更改的文件
    echo "更改的文件:"
    git diff --name-only HEAD
    
    # 添加所有更改
    git add .
    
    # 生成提交信息
    COMMIT_MSG="docs: 更新笔记 - $(date +"%Y-%m-%d %H:%M")"
    
    # 提交更改
    if git commit -m "$COMMIT_MSG"; then
        echo "✅ 本地更改已提交"
        
        # 推送到远程
        echo "📤 推送到远程仓库..."
        if git push origin main; then
            echo "✅ 同步完成！"
        else
            echo "❌ 推送失败，请检查网络连接"
            exit 1
        fi
    else
        echo "❌ 提交失败"
        exit 1
    fi
fi

echo "🎉 笔记同步完成！"