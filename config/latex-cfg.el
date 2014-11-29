; Auctex
(load "auctex.el" :noerror :nomessage :nosuffix)
(load "preview-latex.el" :noerror :nomessage :nosuffix)
; Generera PDF istället för DVI. latex kommer fortfarande användas istället för
; pdflatex, tror jag, men det verkar inte spela någon roll.
(setq TeX-PDF-mode t)
