wget --no-check-certificate -O tgbot.sh https://raw.githubusercontent.com/nameless3721/nash/master/tgbot.sh && chmod +x tgbot.sh && ./tgbot.sh

vi $Path/Telegram-chatbot/config.json

wget --no-check-certificate -O sc.sh https://raw.githubusercontent.com/nameless3721/nash/master/sc.sh && chmod +x sc.sh && ./sc.sh

```
wget --no-check-certificate -O rustss.sh https://raw.githubusercontent.com/nameless3721/nash/master/rustss.sh
chmod +x rustss.sh
./rustss.sh
systemctl restart rustss
systemctl status rustss

wget --no-check-certificate -O uninstall-rustss.sh https://raw.githubusercontent.com/nameless3721/nash/master/uninstall-rustss.sh
chmod +x uninstall-rustss.sh
./uninstall-rustss.sh
```
```
wget https://github.com/pymumu/smartdns/releases/download/Release36.1/smartdns.1.2022.04.05-2046.x86_64-debian-all.deb
dpkg -i smartdns*.deb
wget https://raw.githubusercontent.com/nameless3721/nash/master/smartdns.conf
mv -f smartdns.conf /etc/smartdns/
mkdir -p /etc/systemd/resolved.conf.d/
cat >/etc/systemd/resolved.conf.d/99-dns.conf << EOF
[Resolve]
DNS=127.0.0.1 1.1.1.1
EOF
ln -s -f /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl daemon-reload && systemctl restart systemd-resolved.service && systemctl status -l systemd-resolved.service --no-pager
cat /etc/resolv.conf

#替换解锁ip
sed -i "s/#server 88.88.88.88 -group nf/server 解锁ip -group nf/g" /etc/smartdns/smartdns.conf
systemctl restart smartdns
systemctl enable smartdns
```
```
#解锁nftv
wget -qO nfset.sh https://raw.githubusercontent.com/nameless3721/nash/master/nfset.sh && bash nfset.sh
```
