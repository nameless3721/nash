#!/bin/bash
apt-get update -y
apt install -y python3-pip  git python3


# 安装路径
Path="/root"

# Python的绝对路径
Pythonpath="/usr/bin/python3"

if [ `command -v pip3` ];then
    echo 'pip3 已经安装'
else
    echo -e "\033[31m Error:未安装pip3 请自行安装 \033[0m" 
    exit
fi
#安装
cd $Path
git clone https://github.com/nameless3721/SSRClash.git
cd $Path/SSRClash
pip3 install requests flask-restful

# 建立服务
cat > /etc/systemd/system/SSRClash.service <<EOF
[Unit]
Description=SSRClash server
After=network.target
Wants=network.target

[Service]
Type=simple
PIDFile=/var/run/SSRClash.pid
ExecStart=$Pythonpath $Path/SSRClash/SSR_Clash_API.py
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
echo '#启动SSR_Clash:systemctl start SSRClash'
echo '#重启SSR_Clash:systemctl restart SSRClash'
echo '#开机启动SSR_Clash:systemctl enable SSRClash'
echo '##########################################################'
