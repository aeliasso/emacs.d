(package-initialize)
(eval-when-compile
  ;; Don't error out when use-package is not installed (e.g. on a new
  ;; workstation setup). This will instead cause warnings that the
  ;; symbol use-package is nil but will allow the initialization to
  ;; complete, allowing the user to run
  ;; package-install-selected-packages.
  (require 'use-package nil :noerror))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(compilation-scroll-output 'first-error)
 '(create-lockfiles nil)
 '(cursor-type 'bar)
 '(custom-enabled-themes '(deeper-blue))
 '(default-frame-alist '((width . 81) (height . 52)))
 '(dired-auto-revert-buffer t)
 '(dired-mode-hook '(hl-line-mode))
 '(doc-view-scale-internally nil)
 '(ecb-options-version "2.40")
 '(extended-command-suggest-shorter nil)
 '(fido-mode t)
 '(fill-column 80)
 '(ggtags-oversize-limit 209715200)
 '(ggtags-sort-by-nearness t)
 '(git-commit-summary-max-length 60)
 '(global-auto-revert-mode t)
 '(global-visual-line-mode t)
 '(glyphless-char-display-control '((format-control . acronym) (no-font . hex-code)))
 '(grep-files-aliases '(("everything" . "*")))
 '(help-window-select t)
 '(ibuffer-mode-hook '(hl-line-mode))
 '(inhibit-startup-screen t)
 '(isearch-allow-scroll t)
 '(kill-do-not-save-duplicates t)
 '(magit-auto-revert-mode nil)
 '(markdown-indent-function 'insert-tab)
 '(menu-bar-mode nil)
 '(meson-indent-basic 4)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control))))
 '(org-special-ctrl-a/e t)
 '(org-src-fontify-natively t)
 '(org-support-shift-select t)
 '(package-archive-priorities
   '(("melpa-stable" . 20)
     ("marmalade" . 20)
     ("gnu" . 10)
     ("melpa" . 0)
     ("onpa" . 5)))
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("onpa" . "https://olanilsson.bitbucket.io/packages/")))
 '(package-selected-packages
   '(whole-line-or-region scala-mode yaml-mode lua-mode org-tree-slide unfill graphviz-dot-mode dockerfile-mode groovy-mode vterm rust-mode kconfig-mode dts-mode meson-mode bitbake-modes ggtags magit use-package markdown-mode meson-mode))
 '(prog-mode-hook '(hl-line-mode display-line-numbers-mode))
 '(revert-without-query '(".*"))
 '(ring-bell-function 'ignore)
 '(save-interprogram-paste-before-kill t)
 '(scala-indent:step 4)
 '(scroll-conservatively 10)
 '(sentence-end-double-space nil)
 '(sh-basic-offset 8)
 '(text-mode-hook '(hl-line-mode))
 '(tool-bar-mode nil)
 '(which-function-mode t)
 '(whole-line-or-region-global-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; User local load path
; Config
(add-to-list 'load-path (concat user-emacs-directory "config"))
; Libraries
(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))

(defconst config-files
  (directory-files
   (concat user-emacs-directory "config") nil "\.el$"))
(dolist (cfg config-files) (load-library cfg))

;; Always start maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(put 'upcase-region 'disabled nil)

;; on Linux, the menu/apps key syntax is <menu>
;; on Windows, the menu/apps key syntax is <apps>
;; make the syntax equal
(define-key key-translation-map (kbd "<apps>") (kbd "<menu>"))

(progn
  ;; define set of key sequences
  (define-prefix-command 'my-leader-key-map)

  (define-key my-leader-key-map (kbd "RET") 'execute-extended-command)
  (define-key my-leader-key-map (kbd "<menu>") 'exchange-point-and-mark)

  (define-key my-leader-key-map (kbd "g") 'magit-status))

;; make the menu key as leader key
(global-set-key (kbd "<menu>") 'my-leader-key-map)

(require 'kconfig-mode nil :noerror)

(put 'downcase-region 'disabled nil)

(add-hook 'conf-mode-hook 'hl-line-mode)
(add-hook 'Buffer-menu-mode-hook 'hl-line-mode)

;; Unregister M-left and M-right from vterm's mode map so that they can
;; still be used by windmove.
(with-eval-after-load 'vterm
  (define-key vterm-mode-map [M-left] nil)
  (define-key vterm-mode-map [M-right] nil))

;; https://superuser.com/questions/319545/changing-the-default-emacs-terminal-escape-character
(defun term-use-sensible-escape-char (&rest ignored)
  (term-set-escape-char 24))
(advice-add 'term :after #'term-use-sensible-escape-char)
(advice-add 'serial-term :after #'term-use-sensible-escape-char)
(advice-add 'ansi-term :after #'term-use-sensible-escape-char)

(when (require 'org-tree-slide nil t)
  (global-set-key (kbd "<f8>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle))
(with-eval-after-load "org-tree-slide"
  (define-key org-tree-slide-mode-map (kbd "<f9>") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f10>") 'org-tree-slide-move-next-tree)
  )
