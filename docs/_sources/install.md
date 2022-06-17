# 環境構築

```{warning}
本セクションの記述は[macOS Monterey](https://www.apple.com/jp/macos/monterey/)およびLinuxディストリビューションの一種である[Ubuntu](https://jp.ubuntu.com) 22.04LTSで動作確認しています．Windows OSへの直接インストールは，筆者がWindowsの使い方をほとんど知らないため記載していません．ただし，Windowsにおいても[WSL2](https://docs.microsoft.com/ja-jp/windows/wsl/install)を用いることでUbuntuをはじめとしたLinuxディストリビューションを容易に利用可能なはずです．
```

PyGMTを使うための環境構築には，Pythonのパッケージ管理システムである

- [Anaconda（Miniconda）](https://www.anaconda.com)
- [pip](https://www.python.jp/install/windows/pip.html)

のどちらかを使います．原理的には自分でソースコードから構築することもできるはずですが，PyGMTはそれを動作させるための依存ライブラリが非常に多いため，パッケージ管理システムを使うことを勧めます．

pipはPythonに付属したツールで，Python上で用いるライブラリの管理を行うものである一方，AnacondaはPythonの処理系自体を含むパッケージで，Pythonのみならずそれに（広い意味で）関連した様々なツールのインストールができます．

どちらを使うかは好みの問題だと思いますが，Anaconda（Miniconda）のほうが容易に環境が構築できるようです．一方，Anacondaはライセンスの扱いにやや注意が必要です．

## Anaconda（Miniconda）によるインストール

Anacondaは科学技術計算に必要なライブラリが多く含まれたPython実行環境とそのパッケージ管理システムからなるソフトウェアです．Anacondaをインストールするだけで一通りの計算環境が揃うため便利なものだったのですが，2020年4月より利用規約が[改定](https://www.anaconda.com/blog/sustaining-our-stewardship-of-the-open-source-data-science-community)となり，大規模な商用利用は有償になりました．ただし，[FAQ](https://www.anaconda.com/blog/anaconda-commercial-edition-faq)によると大学関係者や非商用利用に関してはこの条件が適用されないと明記されています．さらに，有償になるのはパッケージ管理の`default`のリポジトリであり，コミュニティで作成されているリポジトリであるconda-forgeの利用については制限がなことが[明言](https://conda-forge.org/blog/posts/2020-11-20-anaconda-tos/)されているようです．

そこで，ここではPythonおよびパッケージ管理コマンドの`conda`を含む最小限のパッケージであるMinicondaを導入し，そこから`conda-forge`のリポジトリを使って環境の構築をする方法を紹介します．Minicondaは[有償ではない](https://www.anaconda.com/end-user-license-agreement-miniconda)ため，この方法ならどなたでも自由に使えるはずです（と，筆者は理解しています）．

### Minicondaのインストール

[公式ページ](https://docs.conda.io/en/latest/miniconda.html)で配布されているインストーラを使います．OSとCPUアーキテクチャごとにインストーラが異なります．また，macOSではダブルクリックでGUIインストールができる（と思われる；未確認）pkg形式と，Linuxと同じシェルスクリプトによるインストーラが提供されています．ここではシェルスクリプトを用います．アーキテクチャが色々あって迷うかもしれませんが，macOSのCPUは，Appleメニュー（デスクトップ左上のリンゴマーク）の『このMacについて』を選ぶと，『プロセッサ』の欄に記載されていますので，そこに`Intel`とあるかどうかで判断できるでしょう．Linuxの場合は（ARM製のCPUを用いたスパコンなど以外では）まず間違いなく`Linux 64-bit`でしょう．

スクリプトをダウンロードしたら，端末（macOSならターミナル.appなど，Linuxならgnome-terminalなど）からそのスクリプトを
```bash
bash $(スクリプト名)
```
として実行し，対話的にy/nを選んでいくことでインストールできます．その際，インストール先も指定できます．デフォルトは`~/miniconda3`のはずです．ただし`~`は自分のホームディレクトリを意味します．インストール時にnoと答えていなければ，自分のシェル設定ファイル（`.bashrc`あるいは`.zshrc`）に`conda`コマンドを実行するための初期設定が書き込まれます．これにより，次回端末（あるいはシェル）起動時より，ターミナルのプロンプトに `(base)` と記載されるはずです．これはAnacondaの提供する仮想環境のうち，デフォルトの環境であることを意味します．

これでインストール作業は終わりですが，`conda`自体を最新版にアップデートしておきましょう．

```bash
conda update conda
```

### 仮想環境の作成とPyGMTのインストール

このままデフォルトの環境にパッケージを追加していってもよいのですが，ここではPyGMT用の**仮想環境**を作成します．このようにすると，パッケージ間のバージョン不整合などのトラブルがあったときに，仮想環境ごと切り替えるということが可能になります．ここでは，本Webサイトで利用するパッケージをまるごと導入する仮想環境`pygmt`を作ってみましょう．

```bash
conda create --name pygmt-howto --channel conda-forge \
python==3.10.5 pygmt==0.5.0 gmt==6.2.0 numpy==1.22.4 scipy==1.8.1 \
obspy==1.3.0 notebook==6.4.11 netcdf4==1.5.8 matplotlib==3.5.1
```
```{note}
コマンドが長いため `\`で適宜改行しています．仮想環境の名前 `pygmt-howto` はお好みで適宜変更するとよいでしょう．
```

```{important}
2022-06-17時点でのPyGMTとGMTの最新版はそれぞれ0.6.1と6.3.0ですが，GMT 6.3.0とPyGMTの組み合わせで，時間軸を横軸とするプロットがうまく生成できない，というトラブルが発生しています．さらにPyGMTは0.6.0以降ではGMTの最低限のバージョンとして6.3.0の最新版を要求しているため，どちらも最新版は使わず，PyGMT 0.5.0とGMT 6.2.0を利用しています．

どちらも2022年内にアップデートがあるでしょうから，状況は近日中に変わると期待されます．
```


上記のコマンドでは，まず `--name` オプションで仮想環境の名前を，`--channel` オプションでパッケージのリポジトリとして `conda-forge` の利用をそれぞれ宣言し，そのあとでインストールする各種パッケージとそのバージョンを `==` でつないで表現しています．PyGMTのほか，科学技術計算に必要なNumPyやSciPy，地震学データ解析に用いるObsPy，実行環境としてJupyter Notebook(`notebook`がそれにあたります）などをインストールしています．
```{note}
なお，まだ本Webで扱われていないパッケージも一部含まれていますが，今後記事を拡張予定です．
```

上記コマンドからわかるように，`conda`ではPythonのライブラリだけではなく，GMTそのものもインストールされます．ですから，GMTを別途インストールしておく必要はありません．また，Python本体も指定したバージョンのものがインストールされます．ライブラリやPythonのバージョン番号は指定しなければ最新版が入ります．

```{tip}
これらのライブラリや実行バイナリは，`miniconda` のインストールディレクトリ下の `envs` ディレクトリに格納されます`miniconda`をデフォルトでホームディレクトリにインストールしている場合，容量の増大にはご注意ください．
```

インストールが完了したら
```bash
conda activate pygmt-howto
```
により仮想環境を有効化します．すると，プロンプトの左側の `(base)` が仮想環境の名前 `(pygmt-howto)` に変わります．もしいつでもこの環境を使いたいならば，シェルの初期設定ファイル（`.bashrc` あるいは `.zshrc` など）に上記の `activate` コマンドを記載しておくとよいでしょう．

一方，仮想環境から抜けるには
```bash
conda deactivate
```
です．もしこの仮想環境が不要になって削除したいときは，仮想環境から`conda deactivate` した状態で
```bash
conda remove -n pygmt-howto --all
```
とします．

## pip によるインストール

`pip` はPythonに付属しているパッケージ管理コマンドです．
`conda`で行ったように，Python本体を仮想化して目的別のパッケージ管理を行う方法も（多数）ありますが，本筋からそれるためここでは割愛します．

PyGMTは`pip`コマンドに対応しており，インストールは
```bash
pip install pygmt==0.5.0
```
とするだけです．ただし，この場合は`conda`と異なり，GMTはあらかじめ別途インストールが必要です．
GMTはパッケージ管理ソフト（macOSならhomebrew, Ubuntuならapt, CentOSやらyumなど）を用いてインストールするのが簡単でしょう．ただし，PyGMTは原則として最新版に近いバージョンのGMTを要求する一方，Linuxのパッケージ管理システムが最新版のインストールに対応していない，ということがままあります．また，特にLinuxにおいては，インストールしたGMTのありかをPyGMTが正しく認識できない，というトラブルがしばしば発生しているようで，[環境変数の設定で回避する必要がある](https://qiita.com/fujitatsu0520/items/14e2e965f9304ddb996b)ようです．特にこだわりがなければ，minicondaによるほうが確実にインストールできるでしょう．

```{important}
Anacondaの節に記載したように，2022年6月時点ではGMT6.3.0とPyGMTを組み合わせることが推奨できません．GMTを独自に導入する場合はご注意ください．
```

そのほかのライブラリも同様にインストールします．
```bash
pip install numpy
pip install scipy
pip install obspy
pip install matplotlib
pip install notebook
pip install netcdf4
```