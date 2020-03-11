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
 '(compilation-scroll-output (quote first-error))
 '(create-lockfiles nil)
 '(cursor-type (quote bar))
 '(custom-enabled-themes (quote (tango-dark)))
 '(default-frame-alist (quote ((width . 81) (height . 52))))
 '(dired-auto-revert-buffer t)
 '(ecb-options-version "2.40")
 '(fill-column 72)
 '(ggtags-oversize-limit 209715200)
 '(ggtags-sort-by-nearness t)
 '(git-commit-summary-max-length 60)
 '(global-hl-line-mode t)
 '(global-visual-line-mode t)
 '(glyphless-char-display-control (quote ((format-control . acronym) (no-font . hex-code))))
 '(help-window-select t)
 '(inhibit-startup-screen t)
 '(isearch-allow-scroll t)
 '(markdown-indent-function (quote insert-tab))
 '(menu-bar-mode nil)
 '(meson-indent-basic 4)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (3 ((shift) . 1) ((control)))))
 '(org-special-ctrl-a/e t)
 '(org-src-fontify-natively t)
 '(org-support-shift-select t)
 '(package-archive-priorities
   (quote
    (("melpa-stable" . 20)
     ("marmalade" . 20)
     ("gnu" . 10)
     ("melpa" . 0)
     ("onpa" . 5))))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("onpa" . "https://olanilsson.bitbucket.io/packages/"))))
 '(package-selected-packages
   (quote
    (kconfig-mode dts-mode meson-mode bitbake-modes ggtags magit use-package markdown-mode meson-mode)))
 '(revert-without-query (quote (".*")))
 '(scroll-conservatively 10)
 '(sentence-end-double-space nil)
 '(sh-basic-offset 8)
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil))
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

;; Emacs Client
(server-start)

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
