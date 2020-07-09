FROM php:7.4-fpm-buster

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y nginx openssh-server \
    && apt-get autoremove -y \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo 'root:iddqd' | chpasswd

COPY run.sh /root/run.sh

EXPOSE 22 80

STOPSIGNAL SIGQUIT

CMD ["/root/run.sh"]