(defun irc ()
  "Start IRC"
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "henrydanvers" :password freenode-password))
