;; Acknowledgements:
; http://whattheemacsd.com/editing-defuns.el-01.html
; https://gist.github.com/jasonm23/4508230

(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1))

(global-set-key (kbd "C-o") 'open-line-below)
(global-set-key (kbd "C-S-o") 'open-line-above)
