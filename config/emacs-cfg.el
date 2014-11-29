; Visa radnummer
(global-linum-mode t)
; TODO: bara linum-mode för kod, inte för fundamental, org eller latex
; Bryt rader vid ordgränser
(global-visual-line-mode t)
; Räkna kolumner (rader räknas som standard)
(column-number-mode t)
; Använd mellanslag istället för tabulatortecken
(setq-default indent-tabs-mode nil)
; Tabulatorstopp vartannat tecken (standard: 4)
(setq-default c-basic-offset 4)
; tab-width = bredden på ett tabulatortecken

(setq-default cursor-type 'bar)

;(set-face-attribute 'default nil :height 120)

; Workaround för att fixa döda tangenter
(require 'iso-transl)

; Stavningskontroll
;(add-to-list 'load-path "~/.emacs.d/elpa/rw-hunspell-2.0")
;(setq ispell-program-name "hunspell")
;(autoload 'rw-hunspell "rw-hunspell")

;; Save backup and auto-save files in a central location
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
; Directory name => Must have trailing slash
(defconst auto-save-dir (expand-file-name
                 (concat user-emacs-directory "autosaves/")))
(setq auto-save-file-name-transforms
      `((".*" ,auto-save-dir t)))

; markdown-mode skickas bara med nyare Emacs-versioner
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\.md" . markdown-mode) auto-mode-alist))
