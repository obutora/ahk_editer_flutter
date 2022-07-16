# ahk_editor_flutter

AutoHotKey 用のスクリプトおよび実行ファイルを、非エンジニアでも自由に編集するための Flutter 製ソフトウェアです。

## 使い方

`setting`フォルダに薬歴データを`.json`形式で保存されています。
まずは`setting`フォルダを読み込むところから始めましょう。

`output`フォルダに生成した`.ahk`ファイルが保存されます。
`.ahk`ファイルは実行用ファイルの検証のために使用します。

`output`フォルダに`.exe`ファイルが保存されています。
これが本体です。

## Entity

### DrugHistory

| type           | name      |
| -------------- | --------- |
| String         | id        |
| List< String > | group     |
| String         | hotString |
| List < Soap >  | soapList  |

### Soap

| type   | name | detail                 |
| ------ | ---- | ---------------------- |
| String | soap | #, S, O, A, EP, OP, CP |
| String | body |

###
