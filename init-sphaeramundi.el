(eval-after-load 'agda2
  (let* ((agda-mode-path (shell-command-to-string "agda-mode locate"))
         (agda-stdlib-path (replace-regexp-in-string "\/share.*$" "/lib/agda/src" agda-mode-path)))
    (if (file-exists-p agda-stdlib-path)
        (setq agda2-include-dirs
              (list "." agda-stdlib-path))
      (error "Agda stdlib directory %s not found." agda-stdlib-path))))
