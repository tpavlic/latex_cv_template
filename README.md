# latex_cv_template

This repository includes `cv.tex`, which is a simple, customizable LaTeX curriculum-vitae (CV) template that is built on top of the `article` documentclass and leverages standard LaTeX packages to create reusable components for structuring the CV sections. Comments within the template explain how to use and customize it (e.g., how to convert it from a CV tailored for academia to a CV/résumé better suited for industry). Some of that information is also summarized here.

- [Preliminaries](#preliminaries)
  - [Required LaTeX Packages](#required-latex-packages)
  - [Building the CV](#building-the-cv)

## Preliminaries

Before using the template, it is advisable to check if the default version can build on your system. The required packages and the conventioanl process for building the CV are detailed here.

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
- `hyperref` (for PDF bookmarks and links; can be removed with minor modifications)
- `lastpage` (optiona; can be removed with minor modifications)
- `times`
  - an alternative to removal is the `draft` option in `hypersetup`
- `url` (optional; can be removed with minor modifications)

If images are to be used within the CV, packages like `graphicx` may also need to be loaded.

### Building the CV

The CV can generally be built with several passes of `pdflatex` (or `latex` if PostScript is required) until the PDF converges (which is particularly important if placing the page number of the last page of the document in the footer), as in:

    pdflatex cv.tex
    pdflatex cv.tex
    pdflatex cv.tex

Alternatively, a build tool such as `latexmk` will automatically run and re-run LaTeX as is necessary, as in:

    latexmk

The `.latexmkrc` included in this repository has been configured for use of `pdflatex` (but can be easily modified or removed for `latex` instead).
