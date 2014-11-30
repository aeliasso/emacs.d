; Auctex
(load "auctex.el" :noerror :nomessage :nosuffix)
(load "preview-latex.el" :noerror :nomessage :nosuffix)
; Generera PDF istället för DVI. latex kommer fortfarande användas istället för
; pdflatex, tror jag, men det verkar inte spela någon roll.
(setq TeX-PDF-mode t)

; Lines aren't really a concept in LaTeX, so it usually makes no sense to
; transpose them. Paragraphs on the other hand:
(add-hook 'latex-mode-hook
          (lambda ()
            (define-key latex-mode-map (kbd "C-x C-t") 'transpose-paragraphs)))
