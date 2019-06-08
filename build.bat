pandoc ja.md -o ja.tex -t latex ^
    --template eisvogel ^
    --highlight-style tango ^
    --number-sections ^
    --toc ^
    -V CJKmainfont="Source Han Serif" ^
    -V mainfont="Source Han Serif" ^
    -V sansfont="Source Han Sans" ^
    -V titlepage=true ^
    -V toc=true ^
    -V toc-title="Contents" ^
    -V toc-own-page=true

xelatex ja.tex