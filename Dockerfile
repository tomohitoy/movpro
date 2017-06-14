#
# Base
#

FROM ubuntu:14.04
MAINTAINER tomohitoy t07840ty@gmail.com

RUN apt-get update -y
RUN chmod go+w,u+s /tmp

# package
RUN apt-get install openssh-server zsh build-essential -y
RUN apt-get install wget unzip curl tree grep bison libssl-dev openssl zlib1g-dev -y



#vim
RUN apt-get update -y
RUN apt-get install git mercurial gettext libncurses5-dev libperl-dev python-dev python3-dev lua5.2 liblua5.2-dev luajit libluajit-5.1 gfortran libopenblas-dev liblapack-dev -y
RUN cd /tmp \
    && git clone https://github.com/vim/vim.git \
    && cd /tmp/vim \
    && ./configure --with-features=huge --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-luainterp --with-luajit --enable-fail-if-missing \
    && make \
    && make install

# sshd config
RUN sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN mkdir /var/run/sshd

# user
RUN echo 'root:root' |chpasswd
RUN useradd -m tomohitoy \
    && echo "tomohitoy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo 'tomohitoy:tomohitoy' | chpasswd
RUN chsh tomohitoy -s $(which zsh)

USER tomohitoy
WORKDIR /home/tomohitoy
ENV HOME /home/tomohitoy

# ssh
RUN mkdir .ssh
ADD id_rsa.pub .ssh/authorized_keys
USER root
RUN chown tomohitoy:tomohitoy -R /home/tomohitoy
RUN chmod 700 .ssh
USER tomohitoy


# dotfiles
RUN git clone https://github.com/tomohitoy/dotfiles.git ~/dotfiles \
    && cd ~/dotfiles \
    && bash bootstrap.sh

# else
USER root
RUN apt-get -y install libav-tools libavcodec-extra-54
USER tomohitoy

# volumes
USER tomohitoy
RUN mkdir /home/tomohitoy/works

# for ssh
USER root
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
