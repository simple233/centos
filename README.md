# Eaypanel模板一键更换脚本
```bash
wget -q https://raw.gitmirror.com/simple233/centos/main/ep.sh -O ep.sh;sh ep.sh
```
# Centos7 更换源

最近CentOS 7已经停止更新支持，同时官方也把yum源删除了，目前CentOS 7系统使用yum命令安装软件包提示“Could not resolve host: mirrorlist.centos.org; Unknown error”，因此需要更换yum源。

在ssh界面执行以下命令即可更换yum源为CentOS的Vault源（包括CentOS官方和阿里云的源）：
```bash
wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.gitmirror.com/simple233/centos/main/Centos-7.repo
yum makecache
```
或者
```bash
curl -o /etc/yum.repos.d/CentOS-Base.repo https://raw.gitmirror.com/simple233/centos/main/Centos-7.repo
yum makecache
```

# 解决CentOS Stream 8停止更新后无法使用yum命令。

在ssh界面执行以下命令即可更换yum源为CentOS的Vault源：
```bash
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
```
```bash
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
```
```bash
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
```
