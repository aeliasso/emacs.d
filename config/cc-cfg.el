;; https://truongtx.me/2013/04/12/emacs-setting-up-perfect-cc-programming-environment/#jump-to-definition--jump-to-implementation
;; https://github.com/leoliu/ggtags
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
	      (ggtags-mode 1))))

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
             '("linux"
	       (c-offsets-alist
                (arglist-cont-nonempty
                 c-lineup-gcc-asm-reg
                 c-lineup-arglist-tabs-only))
	       (indent-tabs-mode . t)))))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-add-style
	     "k&r-spaces-only"
	     '("k&r"
	       (indent-tabs-mode . nil)
               (c-basic-offset . 4)))))

(add-hook 'c-mode-hook
          (lambda ()
	    (if (and buffer-file-name
		     (string-match "linux" buffer-file-name))
		(c-set-style "linux-tabs-only")
	      (c-set-style "k&r-spaces-only"))))

(add-hook 'c-mode-hook
	  (lambda ()
	    (c-add-style
	     "axis"
	     '("k&r-spaces-only"
	       (c-basic-offset . 2)))))

(add-hook 'c-mode-hook
	  (lambda ()
	    (c-add-style
	     "tom"
	     '("k&r-spaces-only"
	       (c-basic-offset . 3)))))
