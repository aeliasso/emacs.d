(use-package magit
  :commands (magit-status magit-define-popup-action))

(defalias 'magit-grep 'vc-git-grep)

;; Make the links in Gerrit's responses clickable
(add-hook 'magit-process-mode-hook 'goto-address-mode)

;; Save files under version control automatically
;(require 'real-auto-save)
; ... how?
;(eval-after-load "vc-git" 'turn-on-real-auto-save)
