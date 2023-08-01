(use-package magit
  :commands (magit-status magit-define-popup-action)
  :config
  ;; cargo-culted from https://github.com/magit/magit/issues/3717#issuecomment-734798341
  (transient-append-suffix 'magit-push "-n"
    '(1 "-w" "Gerrit mark work in progress" "--push-option=wip"))
  (transient-append-suffix 'magit-push "-w"
    '(1 "=t" "Gerrit set topic" "--push-option=topic=")))

(defalias 'magit-grep 'vc-git-grep)

;; Make the links in Gerrit's responses clickable
(add-hook 'magit-process-mode-hook 'goto-address-mode)

(add-hook 'git-commit-mode-hook (lambda () (setq fill-column 72)))
