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

(add-to-list 'auto-mode-alist '("\\.zsh" . sh-mode))

(use-package markdown-mode
  :mode (("\\.markdown\\'" . gfm-mode)
         ("\\.md\\(wn\\)?\\'" . gfm-mode)))

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

;; Move between windows using M-<arrow keys>
(windmove-default-keybindings 'meta)

;; Obsoleted by windmove
;; (global-set-key [C-tab] (lambda () (interactive)(other-window 1)))
;; (global-set-key [C-iso-lefttab] (lambda () (interactive)(other-window 1)))

(when (version<= "26.0.50" emacs-version )
  ;; New in emacs26, replaces linum-mode
  (global-display-line-numbers-mode))

;; Highlight matching parenthesis
(show-paren-mode)

;; http://trey-jackson.blogspot.com/2010/04/emacs-tip-36-abort-minibuffer-when.html
(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

;; Kill the minibuffer when the mouse is clicked
(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

;; Redefine from list-buffers. buffer-menu opens the buffer menu in the
;; current buffer, instead of the other buffer like list-buffer does.
(global-set-key "\C-x\C-b" 'buffer-menu)
