PUT _template/template_1
{
  "index_patterns": "suffix-*",
  "settings": {
    "number_of_shards": 1,
    "analysis": {
      "analyzer": {
        "sudachi_analyzer": {
          "type": "custom",
          "tokenizer": "sudachi_tokenizer"
        },
        "ngram_analyzer": {
          "type": "custom",
          "tokenizer": "ngram_tokenizer"
        }
      },
      "tokenizer": {
        "ngram_tokenizer": {
          "token_chars": [
            "letter",
            "digit"
          ],
          "min_gram": "2",
          "type": "nGram",
          "max_gram": "3"
        },
        "sudachi_tokenizer": {
          "type": "sudachi_tokenizer",
          "mode": "search",
          "discard_punctuation": true,
          "resources_path": "/usr/share/elasticsearch/config/sudachi/",
          "settings_path": "/usr/share/elasticsearch/config/sudachi/sudachi.json"
        }
      }
    }
  },
  "mappings": {
    "_doc": {
      "properties": {
        "text": {
          "type": "text",
          "analyzer": "sudachi_analyzer"
        }
      }
    }
  }
}

GET _template/template_1
GET _cat/templates?v

PUT /suffix-index

GET /suffix-index

POST suffix-index/_doc/
{
    "text" : "お寿司を食べた"
}

# clean up

DELETE _template/template_1
DELETE /suffix-index

GET _template/template_1
GET _cat/indices
