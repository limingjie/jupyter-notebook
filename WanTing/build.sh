#!/bin/zsh

# Follow the guide to install dependencies and fonts
# https://limingjie.github.io/posts/2021-12-28-convert-jupyter-notebook-with-cjk-to-pdf-on-macos/

# Generate HTML
jupyter nbconvert --to html python.ipynb

# Generate Markdown
jupyter nbconvert --to markdown python.ipynb

# Generate Tex
jupyter nbconvert --to latex python.ipynb

# Enable Chinese
# Note: sed MacOS syntax
sed -i '' '3i\
    \\usepackage[slantfont, boldfont]{xeCJK}\
    \\setCJKmainfont{Sarasa UI SC}\
' python.tex

# Change PDF title
# Note: sed MacOS syntax
sed -i '' 's/\\title{python}/\\title{黄师姐 Python 秘籍}/g' python.tex

# Generate PDF
xelatex python.tex > python.pdf

# cleanup
rm python.log python.out python.aux
