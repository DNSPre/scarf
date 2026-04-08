#!/bin/bash
# Hermes WebUI 中文版启动脚本
# 使用方式: ./start-zh.sh

set -e

echo "[hermes-zh] 正在安装依赖..."
pip install -q -r requirements.txt

echo "[hermes-zh] 正在启动 Herm es WebUI (中文版)..."
echo "[hermes-zh] 界面地址: http://localhost:8080"
echo "[hermes-zh] 按 Ctrl+C 停止服务"
echo ""
python server.py "$@"
