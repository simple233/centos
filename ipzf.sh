#!/bin/bash  
  
# 检查是否以root用户运行  
if [ "$(id -u)" -ne 0 ]; then  
   echo "请以root用户运行此脚本"  
   exit 1  
fi  
  
# 读取用户输入的外部转发端口  
read -p "请输入要转发的外部端口号（例如：22222）: " EXTERNAL_PORT  
  
# 检查输入是否为有效的端口号（1-65535）  
if ! [[ "$EXTERNAL_PORT" =~ ^[0-9]+$ ]] || [ "$EXTERNAL_PORT" -lt 1 ] || [ "$EXTERNAL_PORT" -gt 65535 ]; then  
   echo "无效的外部端口号，请输入1到65535之间的数字"  
   exit 1  
fi  
  
# 读取用户输入的内部服务器IP地址  
read -p "请输入内部服务器的IP地址（例如：10.0.0.2）: " INTERNAL_IP  
  
# 使用正则表达式检查IP地址的有效性（简单的IPv4检查）  
if ! [[ "$INTERNAL_IP" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || [[ $(ping -c 1 "$INTERNAL_IP" &> /dev/null && echo $?) -ne 0 ]]; then  
   echo "无效的内部服务器IP地址，请输入有效的IPv4地址并确保该服务器可达"  
   exit 1  
fi  
  
# 读取用户输入的内部服务器端口  
read -p "请输入内部服务器的端口号（例如：22）: " INTERNAL_PORT  
  
# 检查输入是否为有效的端口号（1-65535）  
if ! [[ "$INTERNAL_PORT" =~ ^[0-9]+$ ]] || [ "$INTERNAL_PORT" -lt 1 ] || [ "$INTERNAL_PORT" -gt 65535 ]; then  
   echo "无效的内部端口号，请输入1到65535之间的数字"  
   exit 1  
fi  
  
# 添加iptables规则  
iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport "$EXTERNAL_PORT" -j DNAT --to "$INTERNAL_IP":"$INTERNAL_PORT"  
  
# 检查iptables命令是否成功  
if [ $? -ne 0 ]; then  
   echo "无法添加iptables规则"  
   exit 1  
fi  
  
# 保存iptables规则  
netfilter-persistent save  
  
# 检查netfilter-persistent save命令是否成功  
if [ $? -ne 0 ]; then  
   echo "无法保存iptables规则"  
   exit 1  
fi  
  
# 重新加载iptables规则  
netfilter-persistent reload  
  
# 检查netfilter-persistent reload命令是否成功  
if [ $? -ne 0 ]; then  
   echo "无法重新加载iptables规则"  
   exit 1  
fi  
  
echo "iptables规则已成功添加、保存并重新加载。外部端口 $EXTERNAL_PORT 已转发到 $INTERNAL_IP:$INTERNAL_PORT"