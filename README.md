# latex_cv_template

This repository includes `cv.tex`, which is a simple, customizable LaTeX curriculum-vitae (CV) template that is built on top of the `article` documentclass and leverages standard LaTeX packages to create reusable components for structuring the CV sections. Comments within the template explain how to use and customize it (e.g., how to convert it from a CV tailored for academia to a CV/résumé better suited for industry). Some of that information is also summarized here.

The template can produce an accessible, tagged PDF (one that screen readers and other assistive technology can navigate by heading, list, and link) as well as an ordinary untagged one, from the same source file.

- [Preliminaries](#preliminaries)
  - [Required LaTeX Packages](#required-latex-packages)
  - [Building the CV](#building-the-cv)
- [Accessible (Tagged) PDF](#accessible-tagged-pdf)
  - [What Is Tagged](#what-is-tagged)
  - [Images](#images)
  - [Writing Accessible Content](#writing-accessible-content)
  - [Limits](#limits)

## Preliminaries

Before using the template, it is advisable to check if the default version can build on your system. The required packages and the conventional process for building the CV are detailed here.

### Required LaTeX Packages

This package leverages several standard LaTeX packages that are either typically installed by default in most LaTeX distributions or easy to install from CTAN if not available. Those packages include:

- `article` documentclass (standard with any LaTeX distribution)
- `calc`
- `color` (for colored links; can be removed with minor modifications)
- `doi` (optional; can be removed with few modifications)
- `enumitem`
- `extdash` (optional, but should be removed if not used)
- `fancyhdr`
- `fontenc`
- `geometry`
- `graphicx` (for images; see [Images](#images))
- `hyperref` (for PDF bookmarks and links; can be removed with minor modifications)
- `lastpage` (optional; can be removed with minor modifications)
- `times`
  - an alternative to removal is the `draft` option in `hypersetup`
- `url` (optional; can be removed with minor modifications)

Accessible output needs a LaTeX format from TeX Live 2025 or later (or an equivalent MiKTeX release). The template is written so that an older format simply skips the tagging and builds an untagged PDF, but it has been tested only with TeX Live 2026. The list setup also uses LaTeX hooks, which need a format from mid-2021 or later.

### Building the CV

The same `cv.tex` builds three ways. Run LaTeX until the PDF converges (which is particularly important if placing the page number of the last page of the document in the footer), or let `latexmk` do that for you.

| Route             | Commands                                       | `latexmk`           | Result                                          |
| ----------------- | ---------------------------------------------- | ------------------- | ----------------------------------------------- |
| pdfLaTeX          | `pdflatex cv.tex` (run three times)            | `latexmk`           | Tagged PDF, as accessible as pdfTeX allows      |
| LuaLaTeX          | `lualatex cv.tex` (run three times)            | `latexmk -lualatex` | Tagged PDF/UA with math structure (recommended) |
| DVI to PostScript | `latex cv.tex`, `dvips cv.dvi`, `ps2pdf cv.ps` | `latexmk -pdfps`    | Untagged PDF (not accessible)                   |

The `.latexmkrc` included in this repository makes plain `latexmk` use `pdflatex`. Use the DVI route only if PostScript output is required; the PDF it produces has no structure for assistive technology.

## Accessible (Tagged) PDF

On the pdfLaTeX and LuaLaTeX routes, `cv.tex` turns on PDF tagging (a PDF 2.0 file that declares PDF/UA-2) and sets the document language to US English. The setup is in the block at the top of `cv.tex` that is marked as one to skip over, and it does nothing on the DVI route or on an older LaTeX format.

### What Is Tagged

- Every `\section` is a real heading (and a bookmark), even though its title is set in the left margin.
- The lists (`cvlist`, `bibsection`, and `bibenum`) are tagged as lists with items.
- Links (including e-mail addresses and URLs) are tagged as links.
- The contact block is not a table, so screen readers do not announce a data table.
- Page numbers in the footer are marked as artifacts, so they are not read as part of the content.
- The PDF title and author come from `\hypersetup` in `cv.tex`. Edit them, since a PDF needs a title.
- Math symbols used as bullets or markers get alternative text (see below).

### Images

The template ships with no image files, but it is set up so that every image is either described or marked as decorative:

- `\cvimage[options]{file}{alternative text}` is for an image that carries information, like a photograph or a logo that identifies an organization. The alternative text is what a screen reader speaks.
- `\decorativegraphics[options]{file}` is for an image that adds nothing to the content. Assistive technology skips it.

The `\makeheading` comments in `cv.tex` show a photograph placed across from the name with alternative text. Prefer these two commands to a bare `\includegraphics`, which would leave a figure with no alternative text in a tagged PDF. On the DVI route, use EPS images; on the pdfLaTeX and LuaLaTeX routes, use PDF, PNG, or JPEG.

### Writing Accessible Content

- Use `\begin{cvlist}` for lists. It is tight by default, for the details under an entry, and `\begin{cvlist}[loose]` adds space between entries. Inside, `\item` gives a bulleted item, `\entry` gives an item with no bullet, and `\marker{alternative text}{$...$}` gives an item with a symbol of your own, as in `\marker{dash}{$-$}`. The alternative text is what a screen reader speaks; without it, a screen reader is given a description built from the TeX source.
- Use `\mathalt{alternative text}{$...$}` for a math symbol inside running text, as in `\mathalt{pi}{$\pi$}-calculus`.
- To set list options, use `label=...` keys. The `shortlabels` option of `enumitem` is not available in a tagged PDF.
- Make link text meaningful. A link whose text is only "click here" tells a screen reader user nothing.

### Limits

- pdfLaTeX produces tags but no MathML structure for math, which only LuaLaTeX provides. Formulas in a pdfLaTeX build carry only alternative text.
- In the pdfLaTeX build of the default `cv.tex`, a few pages (four of 21 in the test build) end with one unbalanced marked-content operator in the PDF, which `pdftoppm` reports as `Mismatched EMC operator`. The LuaLaTeX build does not have it. It appears at some page breaks and moves when the layout changes; the cause has not been found, and a strict validator may flag it. Use the LuaLaTeX route when conformance matters.
- This template declares PDF/UA-2 but has not been run through a PDF/UA validator. Check an important document with a checker such as veraPDF or Acrobat's accessibility checker, and open it with a screen reader if possible.
- The tagged builds break lines and pages almost exactly as the DVI build does, but a few paragraphs may break differently, so a page may end a line earlier or later.
