(when (require 'linum)
    (setq linum-format "%3d ")
    (global-linum-mode t)
    (setq line-number-mode t)
    (setq column-number-mode t))