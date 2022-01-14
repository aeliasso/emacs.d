(use-package magit
  :commands (magit-status magit-define-popup-action)
  :config
  ;; cargo-culted from https://github.com/magit/magit/issues/3717#issuecomment-734798341
  (transient-append-suffix 'magit-push "-n"
    '(1 "-W" "Gerrit mark WiP" "--push-option=wip"))
  (transient-append-suffix 'magit-push "-W"
    '(1 "=t" "Gerrit set topic" "--push-option=topic=")))

(defalias 'magit-grep 'vc-git-grep)

;; Make the links in Gerrit's responses clickable
(add-hook 'magit-process-mode-hook 'goto-address-mode)

;; Save files under version control automatically
;(require 'real-auto-save)
; ... how?
;(eval-after-load "vc-git" 'turn-on-real-auto-save)
