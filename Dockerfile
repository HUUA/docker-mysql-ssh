# 使用ubuntu:18.04官方镜像
FROM ubuntu:18.04

# 复制supervisord.cof文件至容器指定目录
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 指定root为当前用户，指定root目录为当前工作目录
USER root
WORKDIR /root

# 安装openssh-server,suervisor,mysql-server,vim,net-tools，配置ssh服务(创建用户密码，创建工作目录，设置允许root用户登录)
RUN apt-get update -y \
    && apt-get install openssh-server supervisor vim net-tools -y \
    && echo 'root:000000' | chpasswd \
    && mkdir /var/run/sshd \
    && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server 

# 暴露端口
EXPOSE 22 3306 

# 制定挂载卷
VOLUME ["/var/lib/mysql", "/var/log/mysql"]

# 容器启动命令
CMD ["/usr/bin/supervisord"]
