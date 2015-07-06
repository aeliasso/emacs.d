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
(defconst backup-dir (expand-file-name
                      (concat user-emacs-directory "backups")))
(if (not (file-exists-p backup-dir))
    (make-directory backup-dir))
(setq backup-directory-alist
      `(("." . ,backup-dir)))
; Directory name => Must have trailing slash
(defconst auto-save-dir (expand-file-name
                 (concat user-emacs-directory "autosaves/")))
(if (not (file-exists-p auto-save-dir))
    (make-directory auto-save-dir))
(setq auto-save-file-name-transforms
      `((".*" ,auto-save-dir t)))

; markdown-mode skickas bara med nyare Emacs-versioner
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\.md" . markdown-mode) auto-mode-alist))

; https://stackoverflow.com/questions/6464738/how-can-i-switch-focus-after-buffer-split-in-emacs
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

; http://www.emacswiki.org/emacs/MarkCommands
(defun my-mark-current-word (&optional arg allow-extend)
  "Put point at beginning of current word, set mark at end."
  (interactive "p\np")
  (setq arg (if arg arg 1))
  (if (and allow-extend
           (or (and (eq last-command this-command) (mark t))
               (region-active-p)))
      (set-mark
       (save-excursion
         (when (< (mark) (point))
           (setq arg (- arg)))
         (goto-char (mark))
         (forward-word arg)
         (point)))
    (let ((wbounds (bounds-of-thing-at-point 'word)))
      (unless (consp wbounds)
        (error "No word at point"))
      (if (>= arg 0)
          (goto-char (car wbounds))
        (goto-char (cdr wbounds)))
      (push-mark (save-excursion
                   (forward-word arg)
                   (point)))
      (activate-mark))))

(global-set-key "\M-@" 'my-mark-current-word)

; http://whattheemacsd.com/key-bindings.el-01.html
(global-set-key [remap goto-line] 'goto-line-with-feedback)

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (if (and (boundp 'linum-mode)
           linum-mode)
      (call-interactively 'goto-line)
    (unwind-protect
        (progn
          (linum-mode 1)
          (call-interactively 'goto-line))
      (linum-mode -1))))

(global-set-key [C-tab] (lambda () (interactive)(other-window 1)))
(global-set-key [C-iso-lefttab] (lambda () (interactive)(other-window 1)))
