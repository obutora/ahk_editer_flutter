# ahk_editor_flutter

AutoHotKey 用のスクリプトおよび実行ファイルを、非エンジニアでも自由に編集するための Flutter 製ソフトウェアです。

## 使い方

## Entity

### DrugHistory

| type           | name      |
| -------------- | --------- |
| String         | id        |
| List< String > | group     |
| String         | hotString |
| List < Soap >  | soapList  |

### Soap

| type   | name | detail              |
| ------ | ---- | ------------------- |
| String | soap | S, O, A, EP, OP, CP |
| String | body |
