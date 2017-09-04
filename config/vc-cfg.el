(use-package magit-gerrit
  :ensure t
  :defer t
  :commands (magit-gerrit-mode magit-gerrit-popup)
  :defines (magit-gerrit-popup-prefix magit-gerrit-ssh-creds)
  :init
  (setq magit-gerrit-popup-prefix "Q")
  (setq-default magit-gerrit-ssh-creds "antone@gittools.se.axis.com")
  )

(use-package magit
  :ensure t
  :commands (magit-status magit-define-popup-action)
  :bind (("<menu>" . magit-status)
		 :map magit-status-mode-map
		 ("M-q" . magit-gerrit-mode))
;:config (require 'coan-magit)
;(add-hook 'magit-status-mode-hook #'coan-add-magit-gerrit-popup-key t)
  )


;; Save files under version control automatically
;(require 'real-auto-save)
; ... how?
;(eval-after-load "vc-git" 'turn-on-real-auto-save)
