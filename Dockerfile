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
RUN dnf -y --exclude=tzdata* install tmux
RUN dnf -y remove vi

RUN cd /tmp/ && \
   git clone https://github.com/vim/vim.git && \
   cd vim && \
   git checkout v9.0.0828 && \
   cd src && \
   ./configure --with-features=huge --enable-multibyte --enable-python3interp --enable-cscope --enable-luainterp && \
   make -j4 && \
   make install && \
   cd /tmp/ && rm -rf ./vim

RUN cd /tmp/; \
   git clone https://github.com/rizsotto/Bear.git && \
   cd Bear && \
   git checkout 2.4.4 && \
   mkdir build && \
   cd build && \
   cmake -DENABLE_UNIT_TESTS=OFF -DENABLE_FUNC_TESTS=OFF ../ && \
   make && make install && \
   cd /tmp/ && rm -rf ./Bear

RUN groupadd -r vim && useradd -m -r -g vim vim
USER vim

RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/vim/.vim/bundle/Vundle.vim
COPY --chown=vim:vim --link .vimrc /home/vim/
RUN vim +PluginInstall +qall

RUN cd /home/vim/.vim/bundle/YouCompleteMe; \
   git checkout 728b4772 && \
   ./install.py --clangd-completer

RUN echo "alias ll='ls -la'" >> /home/vim/.bashrc
RUN echo "alias vi='vim'" >> /home/vim/.bashrc

COPY --chown=vim:vim --link .tmux.conf /home/vim/

ENTRYPOINT cd /sources/ && bash
