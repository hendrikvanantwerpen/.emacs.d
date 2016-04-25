(add-hook 'markdown-mode-hook
          (lambda ()
            (flyspell-mode)
            (flyspell-buffer)))
