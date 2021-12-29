#!/bin/zsh

# Follow the guide to install dependencies and fonts
# https://limingjie.github.io/posts/2021-12-28-convert-jupyter-notebook-with-cjk-to-pdf-on-macos/

FILE="python"

# Remove files
rm $FILE.html $FILE.tex $FILE.md $FILE.pdf

# Generate HTML
jupyter nbconvert --to html $FILE.ipynb
# Install latest nbconvert to get line number option https://github.com/jupyter/nbconvert
# jupyter nbconvert --to html $FILE.ipynb --Highlight2HTML.extra_formatter_options linenos=table

# Generate Markdown
jupyter nbconvert --to markdown $FILE.ipynb

# Generate Tex
jupyter nbconvert --to latex $FILE.ipynb

# Enable CJK
# Note: sed MacOS syntax
sed -i '' '2i\
    \\usepackage[slantfont, boldfont]{xeCJK}\
    \\setCJKmainfont{Sarasa UI SC}' $FILE.tex

# Change PDF title
# Note: sed MacOS syntax
sed -i '' 's/\\title{python}/\\title{黄师姐 Python 秘籍}/g' $FILE.tex

# Generate PDF
xelatex $FILE.tex

# cleanup
rm $FILE.log $FILE.out $FILE.aux
