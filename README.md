## Movie Processing Tool

### はじめに
映像をavconvを使って映像を変換するツールです`./data/works`ディレクトリに映像を放り込んで、映像を変換できます。

### 使い方
```
$ cd ~
$ git clone https://github.com/tomohitoy/movpro.git
$ mkdir ~/.ssh
$ cd .ssh
$ ssh-keygen -t rsa -b 4096 -C "t07840ty@gmail.com"
$ cp id_rsa.pub ~/movpro/
$ cd ~/movpro
$ docker-compose build
$ docker-compose pull
$ docker-compose up -d
$ ssh tomohitoy@0.0.0.0 -p 2222 -i ~/.ssh/id_rsa
```

### ffmpegでmovファイルをmp4へ
```
$ avconv -i hogehoge.mov hogehoge.mp4
```

### 右に90度回転させてmp4へ
```
$ avconv -i hoghoge.mov -vf "transpose=1" hogehoge.mp4
```
