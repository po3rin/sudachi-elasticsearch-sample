FROM ibmjava:8-jre-alpine as dict_builder

## 辞書の種類の指定(small/core/full)
ARG sudachi_dict_type="full"

## ユーザー辞書ソースを持ってくる
COPY sudachi/custom_dict.txt /home

WORKDIR /home

# Sudachiプラグインのjarファイルを持ってくる (バイナリ辞書の作成のため)
RUN wget https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v7.4.0-1.3.1/analysis-sudachi-elasticsearch7.4-1.3.1.zip && \
    unzip analysis-sudachi-elasticsearch7.4-1.3.1.zip && \
    # 用意されているシステム辞書を持ってくる
    wget https://object-storage.tyo2.conoha.io/v1/nc_2520839e1f9641b08211a5c85243124a/sudachi/sudachi-dictionary-20190718-${sudachi_dict_type}.zip && \
    unzip sudachi-dictionary-20190718-${sudachi_dict_type}.zip && \
    # バイナリ辞書の作成
    java -Dfile.encoding=UTF-8 -cp /home/sudachi-0.3.0.jar com.worksap.nlp.sudachi.dictionary.UserDictionaryBuilder -o /home/custom.dic -s /home/sudachi-dictionary-20190718/system_${sudachi_dict_type}.dic /home/custom_dict.txt


FROM elasticsearch:7.4.0

ARG sudachi_dict_type="full"

# Sudachiプラグインの設定ファイル
COPY sudachi/sudachi.json /usr/share/elasticsearch/config/sudachi/
# 前ステージでダウンロードしたSudachiのシステム辞書
COPY --from=dict_builder /home/sudachi-dictionary-20190718/system_${sudachi_dict_type}.dic /usr/share/elasticsearch/config/sudachi/
# 前ステージで作ったユーザー辞書
COPY --from=dict_builder /home/custom.dic /usr/share/elasticsearch/config/sudachi/
# 前ステージでダウンロードしたプラグイン
COPY --from=dict_builder /home/analysis-sudachi-elasticsearch7.4-1.3.1.zip /usr/share/elasticsearch/

# Sudachiプラグインインストール
RUN elasticsearch-plugin install file:///usr/share/elasticsearch/analysis-sudachi-elasticsearch7.4-1.3.1.zip && \
    rm /usr/share/elasticsearch/analysis-sudachi-elasticsearch7.4-1.3.1.zip
