# Convert Jupyter Notebook with CJK to PDF on MacOS

## Install Dependencies

Follow [nbconvert Installation Guide](https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex) to install dependencies.

```shell
pip install nbconvert
pip install pandoc
brew install mactex
```

## Install CJK Font

Use system font or install any CJK font. I recommend [Sarasa Gothic (更纱黑体 / 更紗黑體 / 更紗ゴシック / 사라사고딕)](https://github.com/be5invis/Sarasa-Gothic).

```shell
brew install font-sarasa-gothic
```

## Convert the Notebook to PDF

1. Convert the notebook to tex

    ```shell
    jupyter nbconvert --to latex notebook-to-convert.ipynb
    ```

2. Modify the tex file to add CJK package and set CJK font

    Insert the 2nd and 3rd lines below into notebook-to-convert.tex. Make sure the font is available in system.

    ```tex
    \documentclass[11pt]{article}
        \usepackage[slantfont, boldfont]{xeCJK}
        \setCJKmainfont{Sarasa UI SC}
        \usepackage[breakable]{tcolorbox}
        \usepackage{parskip} % Stop auto-indenting (to mimic markdown behaviour)
    ```

3. Convert tex to pdf

    ```shell
    xelatex notebook-to-convert.tex
    ```

## Shell Script Helper

```shell
#!/bin/zsh

FILE="notebook-to-convert"

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

# Generate PDF
xelatex $FILE.tex

# cleanup
rm $FILE.log $FILE.out $FILE.aux
```
