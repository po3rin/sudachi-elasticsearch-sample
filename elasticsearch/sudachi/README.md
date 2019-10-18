# Sudachi Plugin

形態素解析器 Sudachi の Elasticsearch Plugin 用のディレクトリです。

## 設定

```sudachi.json``` で設定を変更できる。sudachi辞書のタイプを変更する場合は Dockerfile の ARG も変更する必要がある。

## ビルド

手元でビルドする場合は下記のコマンドで実行できる。```pom.xml``` を Elastisearch のバージョンに合わせて修正する必要あり。

```
git clone https://github.com/WorksApplications/elasticsearch-sudachi.git
$ cd elasticsearch-sudachi
$ docker run -it --rm --name my-sudachi-project -v (pwd):/usr/src/mymaven -w /usr/src/mymaven maven:3.3-jdk-8 mvn package
```

## Reference
https://qiita.com/sorami/items/99604ef105f13d2d472b


## 辞書

辞書はここで手に入る
https://github.com/WorksApplications/SudachiDict

辞書を変更する場合は```sudachi.json```の```systemDict```フィールドと、```docker/Dockerfile```の```sudachi_dict_type```を変更する必要があります。
