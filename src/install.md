# PyGMTの環境構築

```{warning}
本セクションの記述は[macOS Monterey](https://www.apple.com/jp/macos/monterey/)およびLinuxディストリビューションの一種である[Ubuntu](https://jp.ubuntu.com) 22.04LTSで動作確認しています．Windows OSへの直接インストールは，筆者がWindowsの使い方をほとんど知らないため記載していません．ただし，Windowsにおいても[WSL2](https://docs.microsoft.com/ja-jp/windows/wsl/install)を用いることでUbuntuをはじめとしたLinuxディストリビューションを容易に利用可能です．
```

PyGMTを使うための環境構築には，Pythonのパッケージ管理システムである

- [Anaconda](https://www.anaconda.com)
- [pip](https://www.python.jp/install/windows/pip.html)

のどちらかを使います．原理的には自分でソースコードから構築することもできるはずですが，PyGMTはそれを動作させるための依存ライブラリが非常に多いため，パッケージ管理システムを使うことを強く勧めます．

pipはPythonに付属したツールで，Python上で用いるライブラリの管理を行うものである一方，AnacondaはPythonの処理系自体を含むパッケージで，Pythonのみならずそれに（広い意味で）関連した様々なツールのインストールができます．

どちらを使うかは好みの問題だと思いますが，特にLinuxにおいては，後述するようにAnacondaのほうが容易に環境が構築できるようです．

## Anacondaによるインストール

Anacondaは