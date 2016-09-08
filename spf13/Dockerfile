FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y gnome-terminal tmux python git curl \
	build-essential g++ locales language-pack-en language-pack-nb

RUN curl -L https://bootstrap.pypa.io/get-pip.py | python \
	&& pip install watchdog tmuxp

# Build vim
RUN apt-get remove vim vim-runtime gvim
RUN apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev

RUN cd ~ && git clone https://github.com/vim/vim.git && cd vim/src \
	&& ./configure --with-features=huge \
            --enable-multibyte \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-gui=gnome2 --enable-cscope --prefix=/usr \
    && make VIMRUNTIMEDIR=/usr/share/vim/vim74 \
    && make install

# Configure locale for gnome-terminal
RUN locale-gen en_US.utf8
ADD locale /etc/default/locale
ENV LC_ALL=en_US.utf8
ENV LANG=en_US.utf8
ENV LANGUAGE=en_US.utf8

# home directory env variable
ENV HOME /root

# tmux config
ADD .tmux.conf $HOME
ADD cpp.yaml $HOME/.tmuxp/

WORKDIR $HOME

# Install spf13
RUN curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh