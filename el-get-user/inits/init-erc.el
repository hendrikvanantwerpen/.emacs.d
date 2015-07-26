(setq erc-autojoin-channels-alist
      '(("freenode.net"
         "#spoofax"
         )))
(add-hook 'erc-after-connect
          '(lambda (server nick)
             (set-process-query-on-exit-flag (get-buffer-process (current-buffer)) nil)))
(defun irc ()
  "Start IRC"
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "henrydanvers" :password freenode-password))
