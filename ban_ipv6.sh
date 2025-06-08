#!/bin/bash

# 操作的文件
operate_file="/etc/sysctl.d/99-sysctl.conf"

# 禁用ipv6
ban_ipv6() {
    local key=$1
    local value=$2

    if grep -q "^${key}" "${operate_file}"; then
        # 如果存在则替换
        sed -i "s|^${key}.*|${key} = ${value}|" "${operate_file}"
    else
        # 如何不存在则添加
        echo "${key} = ${value}" >> "${operate_file}"
    fi
}

# 设置禁用ipv6的三个选项参数
ban_ipv6 "net.ipv6.conf.all.disable_ipv6" 1
ban_ipv6 "net.ipv6.conf.default.disable_ipv6" 1
ban_ipv6 "net.ipv6.conf.lo.disable_ipv6" 1

# 应用配置使操作生效
sysctl -p "${operate_file}"

echo "------------- Successfully disable ipv6 -------------"
