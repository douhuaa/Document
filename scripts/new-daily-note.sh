#!/bin/bash
# 创建今日笔记脚本

# 获取今日日期
TODAY=$(date +"%Y-%m-%d")
DAILY_NOTE_PATH="daily-notes/${TODAY}.md"

# 检查今日笔记是否已存在
if [ -f "$DAILY_NOTE_PATH" ]; then
    echo "今日笔记已存在: $DAILY_NOTE_PATH"
    echo "是否要打开现有笔记? (y/N)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        if command -v code &> /dev/null; then
            code "$DAILY_NOTE_PATH"
        else
            echo "请手动打开: $DAILY_NOTE_PATH"
        fi
    fi
    exit 0
fi

# 从模板创建今日笔记
if [ -f "templates/daily-note-template.md" ]; then
    cp "templates/daily-note-template.md" "$DAILY_NOTE_PATH"
    
    # 替换模板变量
    sed -i "s/{{date}}/${TODAY}/g" "$DAILY_NOTE_PATH"
    sed -i "s/{{time}}/$(date +"%H:%M")/g" "$DAILY_NOTE_PATH"
    
    echo "已创建今日笔记: $DAILY_NOTE_PATH"
    
    # 尝试用 VS Code 打开
    if command -v code &> /dev/null; then
        code "$DAILY_NOTE_PATH"
        echo "已在 VS Code 中打开"
    fi
else
    echo "错误: 找不到日记模板文件"
    exit 1
fi