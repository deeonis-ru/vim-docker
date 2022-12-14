# syntax=docker/dockerfile:1
FROM rockylinux:8

RUN dnf clean packages
RUN dnf -y  update
RUN dnf -y  groupinstall "Development Tools"
RUN dnf -y  install cmake 
RUN dnf -y  install clang
RUN dnf -y  install clang-tools-extra
RUN dnf -y  install python3
RUN dnf -y  install python3-devel
RUN dnf -y  install ncurses-devel
RUN dnf -y  install openssl-devel
RUN dnf -y  install tmux
RUN dnf -y  install epel-release
RUN dnf -y  install the_silver_searcher
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

RUN groupadd -g 1985 -r vim && useradd -m -r -u 1985 -g vim vim
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
