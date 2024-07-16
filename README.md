# centos
#Centos7 请使用以下命令进行换源

wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.gitmirror.com/simple233/centos/main/Centos-7.repo

yum makecache

或者

curl -o /etc/yum.repos.d/CentOS-Base.repo https://raw.gitmirror.com/simple233/centos/main/Centos-7.repo

yum makecache


# 解决CentOS Stream 8停止更新后无法使用yum命令。

在ssh界面执行以下命令即可更换yum源为CentOS的Vault源：

sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo

sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo

sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
