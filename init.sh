#!/bin/bash

set -e  # 任何命令返回非零状态时立即退出

echo "请输入要安装的GO版本的下载URL"
read url
# 从URL中提取文件名
filename=$(basename "$url")
wget "$url"

rm -rf /usr/local/go && tar -C /usr/local -xzf "$filename"
rm "$filename"

if ! grep -q '/usr/local/go/bin' /etc/profile; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
fi

source /etc/profile

go version

if [ $? -eq 0 ];then
    echo "----------------go安装成功-------------------"
fi

#设置python3别名
echo 'alias python=python3' >> /etc/profile

curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install
uv python pin 3.13
uv run python --version
