# Hermes WebUI 中文版

基于 [nesquena/hermes-webui](https://github.com/nesquena/hermes-webui) v0.39.0 的简体中文界面定制版本。

## 文件结构

```
hermes-webui-zh/
├── README-zh.md              # 本说明文件
├── static/
│   ├── index.html            # 汉化后的前端界面（已翻译所有 UI 字符串）
│   ├── sessions-i18n.js      # 会话层汉化补丁（confirm/toast 翻译）
├── start-zh.sh               # 中文版启动脚本
```

## 完整安装步骤

1. 克隆上游仓库：
```bash
git clone https://github.com/nesquena/hermes-webui.git
cd hermes-webui
```

2. 将汉化文件覆盖进去：
```bash
cp <本仓库路径>/hermes-webui-zh/static/index.html static/
cp <本仓库路径>/hermes-webui-zh/static/sessions-i18n.js static/
```

3. 启动：
```bash
pip install -r requirements.txt
python server.py
```

## 主要汉化内容

- 所有导航标签（对话、任务、技能、记忆、空间、配置、待办）
- 所有按钮和操作文本
- 所有表单 placeholder 提示
- 设置面板所有选项
- 确认对话框消息
- Toast 提示消息
- 建议问题（可自定义）

## 许可

与上游 nesquena/hermes-webui 相同。
