# centos
Centos7 请使用以下命令进行换源
wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.gitmirror.com/simple233/centos/main/Centos-7.repo
yum makecache
或者
curl -o /etc/yum.repos.d/CentOS-Base.repo https://raw.gitmirror.com/simple233/centos/main/Centos-7.repo
yum makecache
