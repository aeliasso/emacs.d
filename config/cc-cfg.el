;; cc-mode must be explicitly required for the other stuff in this file to work
(require 'cc-mode)

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

;; https://truongtx.me/2013/01/06/config-yasnippet-and-autocomplete-on-emacs/
;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; From Linux Documentation/CodingStyle
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (let ((filename (buffer-file-name)))
;;               ;; Enable kernel mode for the appropriate files
;;               (when (and filename
;;                          (string-match (expand-file-name "~/src/linux-trees")
;;                                        filename))
;;                 (setq indent-tabs-mode t)
;;                 (c-set-style "linux-tabs-only")))))
