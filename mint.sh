#!/bin/bash

# 文件路径，存储账户信息的文件
ACCOUNT_FILE="account.txt"

# start命令
start() {
    echo "启动中..."
    while IFS= read -r account || [ -n "$account" ]; do
        # 后台执行 python3 main.py x
        python3 main.py "$account" > /dev/null 2>&1 &
    done < "$ACCOUNT_FILE"
    echo "启动完成"
}

# stop命令
stop() {
    echo "停止中..."
    pkill -f "python3 main.py"
    echo "停止完成"
}

# 判断命令参数
case "$1" in
    "start")
        start
        ;;
    "stop")
        stop
        ;;
    *)
        echo "未知命令: $1"
        echo "使用方法: $0 {start|stop}"
        exit 1
        ;;
esac

exit 0
