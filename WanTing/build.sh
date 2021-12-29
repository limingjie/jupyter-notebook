#!/bin/zsh

# Follow the guide to install dependencies and fonts
# https://limingjie.github.io/posts/2021-12-28-convert-jupyter-notebook-with-cjk-to-pdf-on-macos/

# Remove files
rm python.html python.tex python.md python.pdf

# Generate HTML
jupyter nbconvert --to html python.ipynb
# Install latest nbconvert to get line number option https://github.com/jupyter/nbconvert
# jupyter nbconvert --to html python.ipynb --Highlight2HTML.extra_formatter_options linenos=table

# Generate Markdown
jupyter nbconvert --to markdown python.ipynb

# Generate Tex
jupyter nbconvert --to latex python.ipynb

# Enable CJK
# Note: sed MacOS syntax
sed -i '' '2i\
    \\usepackage[slantfont, boldfont]{xeCJK}\
    \\setCJKmainfont{Sarasa UI SC}' python.tex

# Change PDF title
# Note: sed MacOS syntax
sed -i '' 's/\\title{python}/\\title{黄师姐 Python 秘籍}/g' python.tex

# Generate PDF
xelatex python.tex

# cleanup
rm python.log python.out python.aux
