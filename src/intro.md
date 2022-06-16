# PyGMT HowTo for Seismology

本ページは美麗な地図やグラフを作成できるツール[Generic Mapping Tools (GMT)](https://github.com/GenericMappingTools/gmt)のPython インターフェースである[PyGMT](https://www.pygmt.org/)の地震学における利用を主な対象としたチュートリアルです．

## License

Copyright (C) 2021-2022 Takuto Maeda

Webサイトで公開されるコンテンツは[クリエイティブ・コモンズ4.0表示（CC-BY 4.0)](https://creativecommons.org/licenses/by/4.0/)で提供します．また，本Webサイトを生成するためのソースコードおよびWebサイト中に含まれる[ソースコード](https://github.com/tktmyd/pygmt-howto-jp)は[MITライセンス](https://opensource.org/licenses/MIT)で提供します．

The web contents are distributed under [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/). The source codes to build this web contents, and codes appered inside the web contents are distributed under [MIT license](https://opensource.org/licenses/MIT). 

## どのようなツールか

現在のPyGMTやGMTでどのような図が作成できるかは，公式のギャラリーを見てみるのが良いでしょう．

- [GMT](https://docs.generic-mapping-tools.org/latest/gallery.html)
- [PyGMT](https://www.pygmt.org/latest/gallery/)

もともと，GMTはUn*xのコマンドラインツール群として開発されました．単独Postscriptという形式の画像データを生成する多数のコマンド群からなり，シェルスクリプト等によりそれらのコマンドを組み合わせる必要がありました．シェルスクリプトの特性上，どうしても可視化のコードが煩雑になりがちで，再利用性も低くなりがちでした．

```{tip}
とはいえ，最新版のGMTでは，[modern mode](https://docs.generic-mapping-tools.org/latest/cookbook/one-liner.html)の導入により
```
