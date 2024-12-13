# PyGMTの環境構築


```{warning}
本セクションの記述は[macOS Sequoia 15.2](https://www.apple.com/jp/macos/macos-sequoia/)およびLinuxディストリビューションの一種である[Ubuntu](https://jp.ubuntu.com) 24.04LTSで動作確認しています．Windows OSへの直接インストールは，筆者がWindowsの使い方を知らないため記載していません．ただし，Windowsにおいても[WSL2](https://docs.microsoft.com/ja-jp/windows/wsl/install)を用いることでUbuntuをはじめとしたLinuxディストリビューションを容易に利用可能なはずです．
```

PyGMTを使うための環境構築には，Pythonのパッケージ管理システムである

- [conda](https://www.anaconda.com)
- [pip](https://www.python.jp/install/windows/pip.html)

のどちらかを使います．原理的には自分でソースコードから構築することもできるはずですが，PyGMTはそれを動作させるための依存ライブラリがとても多いため，パッケージ管理システムを使うことを勧めます．

`pip`はPythonに付属したツールで，Python上で用いるライブラリの管理を行うものである一方，`conda`はPythonの処理系自体を含むパッケージで，Pythonのみならずそれに（広い意味で）関連した様々なツールをインストールできます．

どちらを使うかは好みの問題だと思いますが，PyGMTについてはcondaのほうが比較的に容易に環境が構築できるようです．ただし，condaはライセンスまわりにやや注意が必要です．

## Anacondaライセンス問題とMiniforgeの利用

`conda` コマンドはもともとAnacondaという科学技術計算に必要なライブラリが多く含まれたPython実行環境とそのパッケージ管理システムの一部でした．Anacondaをインストールするだけで一通りの計算環境が揃うためたいへん便利なものだったのですが，2020年4月より利用規約が[改定](https://www.anaconda.com/blog/sustaining-our-stewardship-of-the-open-source-data-science-community)となり，大規模な商用利用は有償になりました．その時点では大学関係者や非商用利用に関してはこの条件は適用されないと[明記されていた](https://www.anaconda.com/blog/anaconda-commercial-edition-faq)のですが，その後さらにライセンス条件が変更され，2024年現在，事実上Anacondaの無償利用は困難な状況になったようです．

そこで，ここではPythonおよびパッケージ管理コマンドの`conda`を含むコミュニティベースのパッケージ管理システムである[miniforge](https://github.com/conda-forge/miniforge)を利用し，PyGMTの環境を構築します．

```{warning}
以前，このページでは[Miniconda](https://docs.conda.io/en/latest/miniconda.html)とコミュニティベースのリポジトリである `conda-forge` の利用を推奨し，その方法について説明していました．しかしMinicondaはデフォルトの状態ではAnaconda本体のリポジトリを利用する設定となっているため，そのままではライセンスに抵触するおそれがあります．そこで，今後はコミュニティリポジトリの`conda-forge`をデフォルトで使いつつ，従来の`conda`と同じ使い方のできるMiniforgeの利用を推奨します．
```

### Miniforgeのインストール

まずは適当なディレクトリで，miniforgeをダウンロードします．ここでは`curl`コマンドを使った例を示します．

```bash
$ curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```
```{note}
行頭の `$` はシェルのプロンプトです．コマンドそのものには含まれませんのでご注意ください．
```

ダウンロードしたら，そのスクリプトを `bash` コマンドで実行します．
```bash
$ bash Miniforge3-$(uname)-$(uname -m).sh
```

あとは対話的に `y/n` を選んでいくことでMiniforgeインストールできます．その際，インストール先も指定できます．デフォルトは`~/miniforge3`のはずです．ただし`~`は自分のホームディレクトリを意味します．インストール時にnoと答えていなければ，自分のシェル設定ファイル（`.bashrc`あるいは`.zshrc`）に`conda`コマンドを実行するための初期設定が書き込まれます．これにより，次回端末（あるいはシェル）起動時より，ターミナルのプロンプトに `(base)` と表示されるはずです．これは`conda`の`base`仮想環境（標準状態）であることを意味します．

これでインストール作業は終わりですが，`conda`自体を最新版にアップデートしておきましょう．

```bash
conda update conda
```

### 仮想環境の作成とPyGMTのインストール

このままデフォルトの環境にパッケージを追加していってもよいのですが，ここではPyGMT用の**仮想環境**を作成します．このようにすると，パッケージ間のバージョン不整合などのトラブルがあったときに，仮想環境ごと切り替えるということが可能になります．ここでは，本Webサイトで利用するパッケージをまるごと導入する仮想環境`pygmt`を作ってみましょう．ここでは，2023年12月時点で最新となるPyGMT v0.13.0と，GMT v6.5.0 を導入します．

```bash
$ conda create --name pygmt \
  pygmt==0.13.0 gmt==6.5.0 numpy scipy obspy==1.4.1 notebook matplotlib ffmpeg
```

```{note}
コマンドが長いため `\`で適宜改行しています．仮想環境の名前 `pygmt` はお好みで適宜変更するとよいでしょう．
```

上記のコマンドでは，まず `--name` オプションで仮想環境の名前を宣言し，そのあとでインストールする各種パッケージと必要に応じてそのバージョンを `==` でつないで表現しています．PyGMTのほか，科学技術計算に必要なNumPyやSciPy，地震学データ解析に用いるObsPy，実行環境としてJupyter Notebook(`notebook`がそれにあたります）などをまとめてインストールします．

上記コマンドからわかるように，`conda` ではPythonのライブラリだけではなく，GMTそのものもインストールされます．ですから，この環境構築方法では，GMTを別途インストールしておく必要はありません．今回作成した仮想環境のbashから，GMT自体も使うことができます．また，Python本体も指定したバージョンのものがインストールされます．ライブラリやPythonのバージョン番号は指定しなければ最新版が入ります．

```{tip}
これらのライブラリや実行バイナリは，`miniforge` のインストールディレクトリ下の `envs` ディレクトリに格納されます．`miniforge`をデフォルトでホームディレクトリにインストールしている場合，容量の増大にはご注意ください．
```

インストールが完了したら
```bash
conda activate pygmt
```
により仮想環境を有効化します．すると，プロンプトの左側の `(base)` が仮想環境の名前 `(pygmt)` に変わります．もしいつでもこの環境を使いたいならば，シェルの初期設定ファイル（`.bashrc` あるいは `.zshrc` など）に上記の `activate` コマンドを記載しておくとよいでしょう．

一方，仮想環境から抜けるには
```bash
conda deactivate
```
です．もしこの仮想環境が不要になって削除したいときは，仮想環境から`conda deactivate` した状態で
```bash
conda remove -n pygmt --all
```
とします．
