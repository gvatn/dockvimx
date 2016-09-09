FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y gnome-terminal tmux python3.5 git curl \
	build-essential g++ locales language-pack-en language-pack-nb

RUN apt-get install -y python

RUN curl -L https://bootstrap.pypa.io/get-pip.py | python \
	&& pip install watchdog tmuxp

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

# Build requirements
RUN apt-get install -y libtool libtool-bin autoconf automake cmake g++ pkg-config unzip ruby

# Emscripten
RUN apt-get install -y nodejs
RUN curl -OL https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz \
	&& tar -xzf emsdk-portable.tar.gz \
	&& cd emsdk_portable && ./emsdk update \
	&& ./emsdk install latest && ./emsdk activate latest

RUN cd emsdk_portable && /bin/bash -l -c "source ./emsdk_env.sh"

# Compile neovim
RUN apt-get remove vim vim-runtime gvim
WORKDIR $HOME
RUN git clone https://github.com/neovim/neovim.git
RUN curl -L https://bootstrap.pypa.io/get-pip.py | python3
RUN pip2 install --user neovim && pip3 install --user neovim
RUN cd neovim && make install

RUN echo "export EDITOR='nvim'" >> $HOME/.bashrc
RUN echo "source /emsdk_portable/emsdk_env.sh > /dev/null" >> $HOME/.bashrc
# Java for closure compiler
RUN apt-get install -y default-jre

# vim-plug
RUN curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# FZF for fzf plugin
RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && $HOME/.fzf/install --all


RUN mkdir -p $HOME/.config/nvim
ADD init.vim $HOME/.config/nvim/init.vim
# Install plugins from init.vim
#RUN apt-get install -y vim
#RUN vim +PluginInstall +qall $HOME/.config/nvim/init.vim
