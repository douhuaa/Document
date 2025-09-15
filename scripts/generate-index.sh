#!/bin/bash
# 生成知识库索引文件

INDEX_FILE="docs/知识库索引.md"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M")

echo "📚 生成知识库索引..."

# 创建索引文件头部
cat > "$INDEX_FILE" << EOF
# 知识库索引

> 📅 最后更新: $TIMESTAMP  
> 🤖 此文件由脚本自动生成

## 📊 统计信息

EOF

# 统计各类文件数量
TOTAL_MD=$(find . -name "*.md" -not -path "./.git/*" -not -path "./templates/*" | wc -l)
DAILY_NOTES=$(find daily-notes -name "*.md" 2>/dev/null | wc -l || echo 0)
PROJECT_NOTES=$(find projects -name "*.md" 2>/dev/null | wc -l || echo 0)
REFERENCE_NOTES=$(find reference -name "*.md" 2>/dev/null | wc -l || echo 0)

cat >> "$INDEX_FILE" << EOF
- 📝 总笔记数: $TOTAL_MD
- 📅 日记数量: $DAILY_NOTES
- 🎯 项目笔记: $PROJECT_NOTES  
- 📚 参考资料: $REFERENCE_NOTES

## 📁 目录结构

EOF

# 生成目录结构
echo "### 📅 日记笔记" >> "$INDEX_FILE"
if [ -d "daily-notes" ] && [ "$(ls -A daily-notes)" ]; then
    find daily-notes -name "*.md" | sort -r | head -10 | while read -r file; do
        filename=$(basename "$file" .md)
        echo "- [${filename}](./${file})" >> "$INDEX_FILE"
    done
    if [ "$DAILY_NOTES" -gt 10 ]; then
        echo "- ... (还有 $((DAILY_NOTES - 10)) 篇日记)" >> "$INDEX_FILE"
    fi
else
    echo "- 暂无日记" >> "$INDEX_FILE"
fi

echo "" >> "$INDEX_FILE"
echo "### 🎯 项目笔记" >> "$INDEX_FILE"
if [ -d "projects" ] && [ "$(ls -A projects)" ]; then
    find projects -name "*.md" | sort | while read -r file; do
        title=$(head -1 "$file" | sed 's/^# //')
        echo "- [${title}](./${file})" >> "$INDEX_FILE"
    done
else
    echo "- 暂无项目笔记" >> "$INDEX_FILE"
fi

echo "" >> "$INDEX_FILE"
echo "### 📚 参考资料" >> "$INDEX_FILE"
if [ -d "reference" ] && [ "$(ls -A reference)" ]; then
    find reference -name "*.md" | sort | while read -r file; do
        title=$(head -1 "$file" | sed 's/^# //')
        echo "- [${title}](./${file})" >> "$INDEX_FILE"
    done
else
    echo "- 暂无参考资料" >> "$INDEX_FILE"
fi

# 添加标签统计
echo "" >> "$INDEX_FILE"
echo "## 🏷️ 标签统计" >> "$INDEX_FILE"

if command -v grep &> /dev/null; then
    grep -r "^**标签**:" . --include="*.md" 2>/dev/null | \
    sed 's/.*标签\*\*: *//' | \
    tr ' ' '\n' | \
    grep "^#" | \
    sort | uniq -c | sort -nr | head -10 | \
    while read -r count tag; do
        echo "- $tag ($count)" >> "$INDEX_FILE"
    done
fi

echo "" >> "$INDEX_FILE"
echo "---" >> "$INDEX_FILE"
echo "*此索引文件自动生成，请勿手动编辑*" >> "$INDEX_FILE"

echo "✅ 索引文件已生成: $INDEX_FILE"