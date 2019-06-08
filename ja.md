---
title: "Markdown を XeLaTeX 経由で pandoc する件について"
author: ["赤城 茜"]
date: "2019-06-09"
...

# はじめに

[eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template)といういい感じのpandocテンプレートを見つけた。私はこのリポジトリの `README` にあるタイトルページや美しい本のような装丁に惹かれてしまった。結論からいうと使えることは使えたが、プロセス全体としては不完全燃焼に終わった。

# 実際には

1. なぞのエラーが発生する（後述）
1. エラーを避けるために少々遠回りしたビルド工程になった

前者のエラーがなかなかに曲者だった。以下を見てほしい。

```log
> pandoc example.md -o example.pdf --from markdown --template eisvogel --listings

......

[makePDF] Run #1
This is XeTeX, Version 3.14159265-2.6-0.999991 
(TeX Live 2019/W32TeX) (preloaded format=xelatex) restricted \write18 enabled.

entering extended mode
! I can't find file `./tex2pdf.-d78e12153e1834ec'.
<to be read again>
                   \let
<*> ./tex2pdf.-d78e12153e1834ec\input
                                     .tex
(Press Enter to retry, or Control-Z to exit)
Please type another input file name
! Emergency stop.
```

**Emergency stop**. どうしたらこうなる。テンポラリフォルダがあほなのか？徹底的に原因を探りはしたがpandocのGitHubにはそれっぽいissueがなかった。つまりよくわからぬ変なバグってことだ。リセット前のマシン―このエラーを解決するべくリセットを一回キメた―ではこのコマンド自体は通ったのだが......。

で、結局pandocでpdfのビルドするのではなくtexファイルを生成するにとどめることにした。つまり本来の道筋、pandoc → pdfがpandoc → XeLaTeX → pdfに成り果てた。なんていうこと。

# おわりに

なんだよこれ。

`pandoc example.md -o example.pdf --from markdown --template eisvogel --listings` じゃだめなのかよ、前のマシンではこれで（とりあえずは）走ったぞ？結局テンポラリフォルダの処理とかわからずじまいだし、pandoc のバグなのか *TeX のバグなのかもわからない。思いつくようなヒントもないし八方詰まりという他ない。前後左右に歩がくっついてる飛車みたいな。

見つけた問題点としては `code` ブロックを使う、かつビルドコマンドのフラグに `--listings` を含めるとブロックが本文に重なる。またeisvogelはjsarticleなど標準的な日本語組版ライブラリを使っていないので日本語組版をするのはきついだろう。例えば字間の処理はなかなかひどいものだ。

それじゃあ、また。ばいばーい。