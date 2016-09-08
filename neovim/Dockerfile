FROM ubuntu
RUN apt-get update
RUN apt-get install -y git
WORKDIR /home/root
RUN git clone https://github.com/neovim/neovim.git
RUN apt-get install -y libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
RUN apt-get install -y wget
RUN cd neovim && make install

RUN apt-get install -qqy x11-apps

RUN apt-get install -y gnome-terminal python-dbus
RUN apt-get install -y tmux
RUN apt-get install -y curl

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN apt-get update && \
    apt-get install -y curl && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable

RUN echo "\nsource /etc/profile.d/rvm.sh\nrvm use 2.3\n" >> /home/root/.bashrc

RUN /bin/bash -l -c "rvm requirements && rvm install 2.3 && rvm use 2.3"

RUN usermod -G rvm root

RUN echo "export EDITOR='nvim'\n" >> /home/root/.bashrc

RUN /bin/bash -l -c "gem install tmuxinator"

ADD .tmux.conf /root/


RUN mkdir -p /home/root/.config/nvim

RUN apt-get install -y vim-gtk
RUN apt-get install -y xterm

#ADD init.vim /root/.config/nvim/init.vim

#RUN locale-gen --purge en_US.utf8 && dpkg-reconfigure --frontend=noninteractive locales && echo -e 'LANG="en_US.utf8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale && update-locale LANG=en_US.utf8

RUN apt-get install -y locales language-pack-en language-pack-nb

RUN locale-gen en_US.utf8
ADD locale /etc/default/locale

ENV LC_ALL=en_US.utf8
ENV LANG=en_US.utf8
ENV LANGUAGE=en_US.utf8

#RUN echo "dbus-update-activation-environment --all\n" >> /home/root/.bashrc