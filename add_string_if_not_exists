#!/bin/bash

# 定义一个函数来检查文件是否包含某行字符，如果没有则插入
add_string_if_not_exists() {
    local file="$1"
    local search_string="$2"

    # 检查文件中是否包含目标字符串
    if ! grep -Fxq "$search_string" "$file"; then
        # 如果文件不包含该行字符串，则将其插入到文件中
        echo "$search_string" >> "$file"
        echo "String added to file."
    else
        echo "String already exists in file."
    fi
}

# 使用函数：传入文件名和要搜索的字符串
#add_string_if_not_exists "yourfile.txt" "target_string"
