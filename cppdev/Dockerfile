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
ENV YAVIDE_INSTALL_DIR /opt/yavide

RUN cd $HOME && git clone https://github.com/JBakamovic/yavide.git yavide \
	&& mkdir -p $YAVIDE_INSTALL_DIR \
	&& cp -a ./yavide/. $YAVIDE_INSTALL_DIR/

# Install plugins
RUN mkdir -p $YAVIDE_INSTALL_DIR/core/external && cd $YAVIDE_INSTALL_DIR/core/external \
	&& git clone https://github.com/scrooloose/nerdtree nerdtree \
    && git clone https://github.com/Rip-Rip/clang_complete clang_complete \
    && git clone https://github.com/ervandew/supertab supertab \
    && git clone https://github.com/majutsushi/tagbar tagbar \
    && git clone https://github.com/bling/vim-airline vim-airline \
    && git clone https://github.com/vim-scripts/a.vim a.vim \
    && git clone https://github.com/Townk/vim-autoclose vim-autoclose \
    && git clone https://github.com/terryma/vim-multiple-cursors.git vim-multiple-cursors \
    && git clone https://github.com/scrooloose/nerdcommenter nerdcommenter \
    && git clone https://github.com/SirVer/ultisnips ultisnips \
    && git clone https://github.com/tpope/vim-fugitive.git vim-fugitive \
    && git clone https://github.com/airblade/vim-gitgutter.git vim-gitgutter \
    && git clone https://github.com/tpope/vim-pathogen vim-pathogen \
    && git clone https://github.com/JBakamovic/yaflandia.git yaflandia \
    && git clone https://github.com/jeffreyiacono/vim-colors-wombat vim-colors-wombat \
    && git clone https://github.com/morhetz/gruvbox.git gruvbox

# cppcheck
RUN apt-get install -y wget libclang-dev
WORKDIR $YAVIDE_INSTALL_DIR
RUN mkdir -p core/external/cppcheck/download && cd core/external/cppcheck/download \
	&& wget http://sourceforge.net/projects/cppcheck/files/cppcheck/1.67/cppcheck-1.67.tar.bz2/download -O cppcheck.tar.bz2 \
	&& tar xf cppcheck.tar.bz2 && cd cppcheck-1.67 \
	&& make install SRCDIR=build CFGDIR=$YAVIDE_INSTALL_DIR/core/external/cppcheck/cfg HAVE_RULES=yes \
	&& cd ../../ && rm -r download

#RUN cd $YAVIDE_INSTALL_DIR/core/external/clang_complete && make install > install.log

RUN mkdir colors && cd colors \
	&& git clone https://github.com/JBakamovic/yaflandia.git yaflandia \
	&& git clone https://github.com/jeffreyiacono/vim-colors-wombat vim-colors-wombat \
	&& git clone https://github.com/morhetz/gruvbox.git gruvbox \
	&& ln -s `find . -wholename '*/colors/*.vim'` .


WORKDIR $HOME

RUN mkdir -p .fonts \
	&& git clone https://github.com/Lokaltog/powerline-fonts.git .fonts \
	&& fc-cache -vf .fonts

# Set libclang.so location
RUN sed -i '/let g:libclang_location/c\let g:libclang_location = "'`find /usr -path "/usr/lib*/libclang.so"`'"' \
	$YAVIDE_INSTALL_DIR/config/.user_settings.vimrc

# Clang_complete
ADD clang_complete/Makefile $YAVIDE_INSTALL_DIR/core/external/clang_complete/
ADD clang_complete/build.vim $YAVIDE_INSTALL_DIR/core/external/clang_complete/
RUN cd $YAVIDE_INSTALL_DIR/core/external/clang_complete && make install

# yavide command alias
RUN echo "alias yavide=\"vim --servername yavide -f -N -u $YAVIDE_INSTALL_DIR/.vimrc\"" >> .bashrc



RUN cp -R yavide/core . && cp -R yavide/config . 

# tmux config
ADD .tmux.conf $HOME
ADD cpp.yaml $HOME/.tmuxp/