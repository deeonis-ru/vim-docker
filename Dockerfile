# syntax=docker/dockerfile:1
FROM rockylinux:8

RUN dnf clean packages
RUN dnf -y --exclude=tzdata* update
RUN dnf -y --exclude=tzdata* --exclude=java* --exclude=jna groupinstall "Development Tools"
RUN dnf -y --exclude=tzdata* install cmake 
RUN dnf -y --exclude=tzdata* install clang
RUN dnf -y --exclude=tzdata* install clang-tools-extra
RUN dnf -y --exclude=tzdata* install python3
RUN dnf -y --exclude=tzdata* install python3-devel
RUN dnf -y --exclude=tzdata* install ncurses-devel
RUN dnf -y --exclude=tzdata* install openssl-devel

RUN dnf -y remove vi; \
   cd /root/ && \
   git clone https://github.com/vim/vim.git && \
   cd vim && \
   git checkout v9.0.0828 && \
   cd src && \
   ./configure --with-features=huge --enable-multibyte --enable-python3interp --enable-cscope --enable-luainterp && \
   make -j4 && \
   make install && \
   cd /root/ && rm -rf ./vim

RUN cd /root/; \
   git clone https://github.com/rizsotto/Bear.git && \
   cd Bear && \
   git checkout 2.4.4 && \
   mkdir build && \
   cd build && \
   cmake -DENABLE_UNIT_TESTS=OFF -DENABLE_FUNC_TESTS=OFF ../ && \
   make && make install && \
   cd /root/ && rm -rf ./Bear

RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
ADD --link .vimrc /root/
RUN vim +PluginInstall +qall

RUN cd /root/.vim/bundle/YouCompleteMe; \
   git checkout 728b4772 && \
   ./install.py --clangd-completer --force-sudo

RUN echo "alias ll='ls -la'" >> /root/.bashrc
RUN echo "alias vi='vim'" >> /root/.bashrc

RUN dnf -y --exclude=tzdata* install tmux
ADD --link .tmux.conf /root/

ENTRYPOINT cd /sources/ && bash
