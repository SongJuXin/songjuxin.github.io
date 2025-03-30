#!/bin/bash

source ./add_string_if_not_exists.sh

# 检查是否提供了两个参数
if [ $# -ne 2 ]; then
  echo "Usage: $0 <commit-message> <file-name>"
  exit 1
fi

# 从参数中获取提交信息和文件名
data=$1
file_name=$2
file_path="submissions/${file_name}"

# 最大重试次数
max_retries=5
retry_count=0

current_branch=$(git rev-parse --abbrev-ref HEAD)
while [ $retry_count -lt $max_retries ]; do
  git fetch origin
  git merge origin/$current_branch --no-edit
  if [ $? -eq 0 ]; then
    add_string_if_not_exists "submissions/index.txt" "${filename}:${date +%s}"
    echo "$data" >> "$file_path"
    git add "$file_path"
    git commit -m "update$file_name"
    git push
    if [ $? -eq 0 ]; then
      echo "Push successful"
      break
    else
      echo "Push failed, retrying... ($((retry_count+1))/$max_retries)"
    fi
  else
    echo "Merge failed, retrying... ($((retry_count+1))/$max_retries)"
    git merge --abort
  fi
  retry_count=$((retry_count+1))
  sleep 1
done

if [ $retry_count -ge $max_retries ]; then
  echo "Reached maximum retry count. Exiting."
fi
