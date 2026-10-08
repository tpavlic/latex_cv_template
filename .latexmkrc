# Default build: a tagged (accessible) PDF made directly by pdfLaTeX.
#
# Other routes, chosen on the command line (latexmk keeps the same file):
#   latexmk -lualatex   tagged PDF/UA with math structure (best accessibility)
#   latexmk -pdfps      DVI -> PostScript -> PDF (untagged, so not accessible)
$pdf_mode = 1;
