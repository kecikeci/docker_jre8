# oracle server-jre-8u181 centos7.2源+阿里云yum源+常用软件
# 个人博客：https://4xx.me
FROM hub.c.163.com/library/centos:7.2.1511
MAINTAINER https://4xx.me

RUN yum install wget -y

# 更换阿里源
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# 安装常用软件
RUN yum clean all
RUN yum install -y yum-plugin-ovl || true
RUN yum install -y vim tar wget curl rsync bzip2 iptables tcpdump less telnet net-tools lsof sysstat cronie passwd openssl openssh-server epel-release kde-l10n-Chinese glibc-common

# 安装openjdk1.8
RUN yum remove java* -y
RUN wget -O /root/jre-8u181-linux-x64.rpm https://test-1256264023.cos.ap-chengdu.myqcloud.com/jre-8u181-linux-x64.rpm
RUN rpm -ivh /root/jre-8u181-linux-x64.rpm
RUN rm -rf /root/jre-8u181-linux-x64.rpm

# 更新yum包 更新最新内核
RUN yum update -y

# 中文设置
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LANG="zh_CN.UTF-8" 

# 时区设置
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

# 清除yum缓存
RUN yum clean all
RUN rm -rf /var/cache/yum/*