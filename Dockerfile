FROM debian

RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    pwgen git curl wget zsh vim \
    && rm -r /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
# seems to to obsolet in debian stretch
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

VOLUME ["/var/log", "/home", "/root"]

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
