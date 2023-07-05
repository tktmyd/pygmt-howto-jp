import sys
import os
import pygmt
import numpy as np


def plot_fig(phi):
    
    """ 初期位相 `phi` の sin カーブを描画する．"""

    x = np.linspace(0, 5, 201)
    y = np.sin(2*np.pi*x + phi)
    
    fig = pygmt.Figure()
    
    fig.plot(region = [0, 5, -1.1, 1.1], projection = 'X10c/4c', 
             x = x, y = y, 
             pen = 'thick,200/110/30', frame = ['WS', 'xaf', 'yaf'])

    return fig


if __name__ == "__main__": # スクリプトとして実行したときにはこの行以下が実行される
    
    # コマンドライン引数
    dir_out = sys.argv[1]
    i = int(sys.argv[2])
    
    # 引数 i -> 角度 phi
    nmax = 200
    phi = 2 * np.pi * i / nmax
    
    # 画像生成
    f = plot_fig(phi)

    # 画像保存
    figname = f'plot_{i:03d}.png' 
    f.savefig(os.path.join(dir_out, figname))