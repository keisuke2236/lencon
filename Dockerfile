FROM ubuntu:18.04
MAINTAINER showwin <showwin_kmc@yahoo.co.jp>

ENV LANG en_US.UTF-8

RUN apt-get update
RUN apt-get install -y wget sudo less vim tzdata

# lencon ユーザ作成
RUN groupadd -g 1001 lencon && \
    useradd  -g lencon -G sudo -m -s /bin/bash lencon && \
    echo 'lencon:lencon' | chpasswd
RUN echo 'lencon ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# MySQL のインストール
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password password lencon'"]
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-service mysql-server/mysql-apt-config string 4'"]
RUN apt-get install -y mysql-server

# Nginx のインストール
RUN apt-get install -y nginx
COPY admin/ssl/ /etc/nginx/ssl/
COPY admin/config/nginx.conf /etc/nginx/nginx.conf

USER lencon

# Ruby のインストール
RUN sudo apt-get install -y git ruby-dev libssl-dev libreadline-dev gcc make libmysqlclient-dev && \
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN PATH="$HOME/.rbenv/bin:$PATH" && \
    eval "$(rbenv init -)" && \
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    rbenv install 2.5.1 && rbenv rehash && rbenv global 2.5.1

# アプリケーション
RUN mkdir /home/lencon/data /home/lencon/webapp
COPY admin/lencon2.dump.tar.bz2 /home/lencon/data/lencon2.dump.tar.bz2
COPY webapp/ /home/lencon/webapp
COPY admin/config/bashrc /home/lencon/.bashrc

# ライブラリのインストール
RUN cd /home/lencon/webapp/ruby && sudo gem install bundler && bundle install
COPY docker/start_app.sh /docker/start_app.sh

WORKDIR /home/lencon
EXPOSE 443
