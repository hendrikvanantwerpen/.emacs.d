(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)
            (flyspell-buffer)))
(set-display-table-slot standard-display-table
                        'selective-display
                        (string-to-vector "⋯"))
