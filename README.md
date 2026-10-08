# latex_cv_template

This repository includes `cv.tex`, which is a simple, customizable LaTeX curriculum-vitae (CV) template that is built on top of the `article` documentclass and leverages standard LaTeX packages to create reusable components for structuring the CV sections. Comments within the template explain how to use and customize it (e.g., how to convert it from a CV tailored for academia to a CV/résumé better suited for industry). Some of that information is also summarized here.

The template can produce an accessible, tagged PDF (one that screen readers and other assistive technology can navigate by heading, list, and link) as well as an ordinary untagged one, from the same source file.

![First page of the default CV: the name and a rule across the top, then Contact Information with an address on the left and phone, e-mail, and web address on the right, Research Interests as a paragraph, and Current and Previous Academic Appointments as entries with titles on the left, dates on the right, and bulleted details below. Each section title is set in small capitals in the left margin.](images/cv-page-1.png)

The image above is page 1 of the default build. The CV is 21 pages long.

- [Preliminaries](#preliminaries)
  - [Required LaTeX Packages](#required-latex-packages)
  - [Building the CV](#building-the-cv)
- [Using the Template](#using-the-template)
  - [Structure of a CV](#structure-of-a-cv)
  - [Lists](#lists)
  - [A Worked Example](#a-worked-example)
  - [Reference Lists](#reference-lists)
  - [Spacing and Links](#spacing-and-links)
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

## Using the Template

Edit `cv.tex` from the line `\begin{document}` onward to write your CV. The comments near the top of the file say which parts to edit and which to skip over. The comments next to each macro (under "HELPER COMMANDS") give the full usage; this section is a summary.

### Structure of a CV

Start with `\makeheading{Your Name}`, then write one `\section{Title}` per section. Section titles are set in the left margin, and the text of the section starts on the same line as its title. The heading can also carry something on the right, such as `\makeheading[\emph{Curriculum vitae}]{Your Name}`, or a picture (see [Images](#images)).

### Lists

All of the entries in a CV are `cvlist` lists. A list is tight by default, which suits the details under an entry. Add `[loose]` for the entries of a section (jobs, courses, awards), which puts space between them and makes the start of the list a preferred place for a page to break. Lists nest up to three deep, and tight and loose lists can be mixed. Inside a list:

| Command                  | Item                                                       |
| ------------------------ | ---------------------------------------------------------- |
| `\item`                  | has a bullet                                               |
| `\entry`                 | has no bullet (use for the heading line of an entry)       |
| `\marker{alt text}{$-$}` | has a symbol you choose instead of a bullet, with alt text |

### A Worked Example

The contact information is three boxes side by side, with the address on the left and the phone, e-mail, and web address on the right (`\rcollength` and `\spacewidth`, set just above this block in `cv.tex`, are the width of the right box and the gap between the boxes). Each entry after that follows the pattern the template uses: a line naming the employer, then a loose list whose items are headings with a right-aligned date, each followed by a tight list of details. The reference list at the end is explained in the next section.

```latex
\makeheading{Your Name}

\section{Contact Information}

\noindent
\parbox[t]{\textwidth-\rcollength-\spacewidth}{%
    \href{https://www.example.edu/}{Example University}\\
    Department of Examples\\
    123 Main Street\\
    Anytown, ST 12345  USA}%
\parbox[t]{\spacewidth}{\mbox{}}%
\parbox[t]{\rcollength}{%
    \textit{Phone:} +1-555-555-0100 \\
    \textit{E-mail:} \email{you@example.edu}\\
    \textit{WWW:} \href{https://www.example.com/}{www.example.com}}\par

\section{Experience}

\href{https://www.example.edu/}{\textbf{Example University}}, Anytown
\begin{cvlist}[loose]

    \entry \textit{Assistant Professor} \hfill \textbf{August 2020 to present}
    \begin{cvlist}
        \item Teach graduate courses in simulation
        \item Advise four doctoral students
        \begin{cvlist}
            \marker{dash}{$-$} Two are co-advised with the biology department
        \end{cvlist}
    \end{cvlist}

    \entry \textit{Postdoctoral Scholar} \hfill \textbf{June 2017 to July 2020}
    \begin{cvlist}
        \item Developed models of collective behavior
    \end{cvlist}

\end{cvlist}

\section{Publications}

\begin{bibenum}
    \item Doe, J. and R.~Roe. A title that goes here.
        \emph{Journal of Examples}, 1:1--10. 2020.
        \doi{10.1000/example}
\end{bibenum}
```

It produces this (the footer is left out here):

![Rendered worked example: the name with a rule beneath it, a Contact Information section with an address on the left and phone, e-mail, and web address on the right, then an Experience section naming Example University, with two entries in italics, Assistant Professor and Postdoctoral Scholar, each with dates in bold at the right margin and bulleted details below, one of them with a dash sub-item, followed by a Publications section with one numbered reference.](images/worked-example.png)

<!--
To regenerate the two images in images/ (both made with lualatex):
  cv-page-1.png: build cv.tex, then
    pdftoppm -r 130 -f 1 -l 1 -png cv.pdf p
    magick p-01.png -colors 48 -strip PNG8:images/cv-page-1.png
  worked-example.png: copy cv.tex, put the example above after
    \begin{document} (keep the \newlength lines for \rcollength and
    \spacewidth from cv.tex's Contact section before it), change
    \pagestyle{fancy} to \pagestyle{empty}, build, then
    pdftoppm -r 150 -f 1 -l 1 -png cv.pdf e
    magick e-1.png -trim +repage -bordercolor white -border 24 \
        -colors 32 -strip PNG8:images/worked-example.png
-->

### Reference Lists

Use `bibenum` for a numbered list (publications, for instance) and `bibsection` for an unnumbered one, with `\item` for each reference. Both give each reference a hanging indent. Numbers in `bibenum` continue from one list to the next, so give `\restartlist{bibenum}` where the numbering should start over.

### Spacing and Links

- `\blankline` and `\halfblankline` add a full or half line of space where a page break is welcome. Put each on a line of its own between paragraphs, not inside one.
- `\email{you@example.edu}` is a link that opens a mail message, and `\url{...}` and `\href{url}{text}` are the usual links. In the template, links are dark blue.
- `\doi{10.1000/example}` links a DOI.

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

- Use `cvlist` for lists (see [Lists](#lists)). `\entry` and `\marker` exist because an empty `\item[]` is replaced by the default bullet in a tagged PDF. The alternative text in `\marker{alternative text}{$...$}` is what a screen reader speaks; without it, a screen reader is given a description built from the TeX source.
- Use `\mathalt{alternative text}{$...$}` for a math symbol inside running text, as in `\mathalt{pi}{$\pi$}-calculus`.
- To set list options, use `label=...` keys. The `shortlabels` option of `enumitem` is not available in a tagged PDF.
- Make link text meaningful. A link whose text is only "click here" tells a screen reader user nothing.

### Limits

- pdfLaTeX produces tags but no MathML structure for math, which only LuaLaTeX provides. Formulas in a pdfLaTeX build carry only alternative text.
- In the pdfLaTeX build of the default `cv.tex`, a few pages (four of 21 in the test build) end with one unbalanced marked-content operator in the PDF, which `pdftoppm` reports as `Mismatched EMC operator`. The LuaLaTeX build does not have it. It appears at some page breaks and moves when the layout changes; the cause has not been found, and a strict validator may flag it. Use the LuaLaTeX route when conformance matters.
- This template declares PDF/UA-2 but has not been run through a PDF/UA validator. Check an important document with a checker such as veraPDF or Acrobat's accessibility checker, and open it with a screen reader if possible.
- The tagged builds break lines and pages almost exactly as the DVI build does, but a few paragraphs may break differently, so a page may end a line earlier or later.
