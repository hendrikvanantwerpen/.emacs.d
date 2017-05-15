(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)
            (flyspell-buffer)))
