;; cc-mode must be explicitly required for the other stuff in this file to work
(require 'cc-mode)
;; https://truongtx.me/2013/03/10/emacs-setting-up-perfect-environment-for-cc-programming/
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

;; The MELPA ECB release 20140215.114 is broken.
;; http://stackoverflow.com/questions/20847874/installing-ecb-in-emacs-24-in-ubuntu
(add-to-list 'load-path "~/git/ecb")
;; https://truongtx.me/2013/03/10/ecb-emacs-code-browser/
(require 'ecb)

;; ;;; activate and deactivate ecb
;; (global-set-key (kbd "C-x C-;") 'ecb-activate)
;; (global-set-key (kbd "C-x C-'") 'ecb-deactivate)
;; ;;; show/hide ecb window
;; (global-set-key (kbd "C-;") 'ecb-show-ecb-windows)
;; (global-set-key (kbd "C-'") 'ecb-hide-ecb-windows)
;; ;;; quick navigation between ecb windows
;; (global-set-key (kbd "C-)") 'ecb-goto-window-edit1)
;; (global-set-key (kbd "C-!") 'ecb-goto-window-directories)
;; (global-set-key (kbd "C-@") 'ecb-goto-window-sources)
;; (global-set-key (kbd "C-#") 'ecb-goto-window-methods)
;; (global-set-key (kbd "C-$") 'ecb-goto-window-compilation)

;; eventuellt ersätt ecb-deactivate, ecb-show-ecb-windows och
;; ecb-hide-ecb-windows med egna funktioner

(setq ecb-tip-of-the-day nil)
;;(setq ecb-layout-name "left8") ; default, bra

;; https://truongtx.me/2013/04/12/emacs-setting-up-perfect-cc-programming-environment/#jump-to-definition--jump-to-implementation
;; https://github.com/leoliu/ggtags
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(setq ecb-compile-window-height 12)
