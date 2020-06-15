port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: 127.0.0.1:9090
#hosts:
#  services.googleapis.cn : 172.217.24.195
dns:
  enable: true
  listen: 127.0.0.1:53
  default-nameserver:
    - 223.5.5.5
    - 1.0.0.1
  ipv6: false
  enhanced-mode: fake-ip
  fake-ip-range: 198.10.0.1/16
  nameserver:
    - 119.29.29.29
    - 223.6.6.6
    # - https://dns.alidns.com/dns-query
    # - https://doh.rixcloud.dev/dns-query
    # - https://120.25.25.166/dns-query
{% if local.clash.new_field_name == "true" %}
proxies: ~
proxy-groups: ~
rules: ~
{% else %}
Proxy: ~
Proxy Group: ~
Rule: ~
{% endif %}
