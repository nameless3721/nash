#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
CONF="/etc/rustss/rustss-server.json"
SYSTEMD="/etc/systemd/system/rustss.service"
apt-get -y install nano wget
cd ~/
wget --no-check-certificate -O rustss.tar.xz https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.8.23/shadowsocks-v1.8.23.x86_64-unknown-linux-gnu.tar.xz
tar -xvJf rustss.tar.xz
rm -f rustss.tar.xz
chmod +x ssserver
chmod +x sslocal
chmod +x ssmanager
chmod +x ssurl
mv -f ssserver /usr/local/bin/
mv -f sslocal /usr/local/bin/
mv -f ssmanager /usr/local/bin/
mv -f ssurl /usr/local/bin/
if [ -f ${CONF} ]; then
  echo "Found existing config..."
  else
  if [ -z ${PSK} ]; then
    PSK=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)
    echo "Using generated PSK: ${PSK}"
  else
    echo "Using predefined PSK: ${PSK}"
  fi
  read -p "输入端口或者23456" port
  [ -z "${port}" ] && port='23456'
  read -p "输入密码或者随机" rustsspwd
  [ -z "${rustsspwd}" ] && rustsspwd=${PSK}
  mkdir /etc/rustss/
  echo "Generating new config..."
  echo "{" >>${CONF}
  echo "    \"server\": \"0.0.0.0\"," >>${CONF}
  echo "    \"server_port\": $port," >>${CONF}
  echo "    \"password\": \"$rustsspwd\"," >>${CONF}
  echo "    \"timeout\": 60," >>${CONF}
  echo "    \"mode\":\"tcp_and_udp\"," >>${CONF}
  echo "    \"method\": \"rc4-md5\"" >>${CONF}
  echo "}" >>${CONF}
fi
if [ -f ${SYSTEMD} ]; then
  echo "Found existing service..."
  systemctl daemon-reload
  systemctl restart rustss
else
  echo "Generating new service..."
  echo "[Unit]" >>${SYSTEMD}
  echo "Description=Rustss Proxy Service" >>${SYSTEMD}
  echo "After=network.target" >>${SYSTEMD}
  echo "" >>${SYSTEMD}
  echo "[Service]" >>${SYSTEMD}
  echo "Type=simple" >>${SYSTEMD}
  echo "LimitAS=infinity" >>${SYSTEMD}
  echo "LimitRSS=infinity" >>${SYSTEMD}
  echo "LimitCORE=infinity" >>${SYSTEMD}
  echo "LimitNOFILE=65535" >>${SYSTEMD}
  echo "ExecStart=/usr/local/bin/ssserver -c /etc/rustss/rustss-server.json" >>${SYSTEMD}
  echo "Restart=always" >>${SYSTEMD}
  echo "RestartSec=10" >>${SYSTEMD}
  echo "" >>${SYSTEMD}
  echo "[Install]" >>${SYSTEMD}
  echo "WantedBy=multi-user.target" >>${SYSTEMD}
  systemctl daemon-reload
  systemctl enable rustss
  systemctl start rustss
  ssurl -e /etc/rustss/rustss-server.json
fi
echo '##########################################################'
echo '#修改配置:nano /etc/rustss/rustss-server.json'
echo '#启动ss:systemctl restart rustss'
echo '#获取url自行改ip:ssurl -e /etc/rustss/rustss-server.json'
echo '##########################################################'
