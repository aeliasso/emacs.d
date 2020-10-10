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

;; Don't want it in DocView though!
(add-hook 'doc-view-mode-hook 'my-inhibit-global-display-line-numbers-mode)

(defun my-inhibit-global-display-line-numbers-mode ()
  "Counter-act `global-display-line-numbers-mode'."
  (add-hook 'after-change-major-mode-hook
            (lambda () (display-line-numbers-mode 0))
            :append :local))

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

;; https://github.com/syl20bnr/spacemacs/blob/develop/doc/FAQ.org#include-underscores-in-word-motions
;; For all programming modes
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; https://stackoverflow.com/questions/12289903/how-do-i-go-to-a-local-variables-definition-with-emacs-and-gnu-global
;; + xref-push-marker-stack to be able to return using M-,
(defun bhj-isearch-from-bod (&optional col-indent)
  (interactive "p")
  (xref-push-marker-stack)
  (let ((word (current-word)))
    (beginning-of-defun)
    (setq regexp-search-ring (cons (concat "\\b" word "\\b") regexp-search-ring))
    (search-forward-regexp (concat "\\b" word "\\b"))))
(global-set-key "\M-_" 'bhj-isearch-from-bod)

(add-hook 'markdown-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (local-unset-key (kbd "M-<left>"))
	    (local-unset-key (kbd "M-<right>"))))

;; https://stackoverflow.com/questions/9656311/conflict-resolution-with-emacs-ediff-how-can-i-take-the-changes-of-both-version/29757750#29757750
(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)
