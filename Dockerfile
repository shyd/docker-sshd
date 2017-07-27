FROM shyd/zsh

RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    pwgen && \
    rm -r /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN PASSWD=$(pwgen -s1 32) && \
    echo "root:$PASSWD" | chpasswd && \
    echo "###############################################" && \
    echo "root password: $PASSWD" && \
    echo "###############################################"

# make sure to uncomment this line in /etc/ssh/sshd_config after setting up passwordless login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN chsh -s $(which zsh)

# SSH login fix. Otherwise user is kicked off after login
# seems to to obsolet in debian stretch
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

VOLUME ["/root", "/etc/ssh"]

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
