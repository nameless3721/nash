#!/bin/bash
apt-get update -y
apt install -y python-pip  git

# 安装路径
Path="/root"
# 管理员数字ID
Adminid="123456"
# 机器人Token
BotToken="1234:ABCD"
# Python的绝对路径
Pythonpath="/usr/bin/python"

if [ `command -v pip` ];then
    echo 'pip 已经安装'
else
    echo -e "\033[31m Error:未安装pip 请自行安装 \033[0m" 
    exit
fi
#安装
cd $Path
git clone https://github.com/610312586/Telegram-chatbot
cd $Path/Telegram-chatbot
pip install python-telegram-bot
mv config-default.json config.json
cat << EOF > ./config.json
{
    "Admin": $Adminid,
    "//1": "管理员用户ID（数字ID）（可以先不设）",
    "Token": "$BotToken",
    "//2": "机器人Token",
    "Lang": "zh",
    "//3": "语言包名称",
    "manager8": 1,
    "manager7": 1,
    "manager6": 1,
    "//6": "以上三行可以是最多三个管理员或者bot测试者、开发者"
}
EOF
# 建立服务
cat > /etc/systemd/system/tgbot.service <<EOF
[Unit]
Description=TGbot server
After=network.target
Wants=network.target

[Service]
Type=simple
PIDFile=/var/run/Tgbot.pid
ExecStart=$Pythonpath $Path/Telegram-chatbot/main.py
RestartPreventExitStatus=23
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target
EOF
clear
# 资料
echo '##########################################################'
echo '#启动BOT:systemctl start tgbot'
echo '#开机启动:systemctl enable tgbot'
echo '#程序来自:https://github.com/610312586/Telegram-chatbot'
echo '#BOT指令文档:https://github.com/610312586/Telegram-chatbot/blob/master/README.md'
echo '##########################################################'
