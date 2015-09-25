; setup el-get and MELPA

(when (file-exists-p "~/.secrets.el")
  (load "~/.secrets.el"))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(setq el-get-user-package-directory "~/.emacs.d/el-get-user/inits")

(setq my:el-get-packages
      '(
        ac-ghc-mod
        ac-js2
        ac-math
        ac-python
        amd-mode
        auctex
        auctex-latexmk
        auto-complete
        auto-complete-auctex
        auto-complete-css
        auto-complete-emacs-lisp
        auto-complete-latex
        auto-complete-ruby
        auto-complete-yasnippet
        autopair
        coffee-mode
        ebib
        el-get
        ensime
        erc
        evil
        flyspell
        full-ack
        haskell-mode
        init-loader
        js-pkg
        js2-mode
        js2-refactor
        json
        latex-pretty-symbols
        linum-off
        load-dir
        lorem-ipsum
        markdown-mode
        ;mvn
        python-mode
        rainbow-delimiters
        reftex
        sbt-mode
        scala-mode2
        semver
        smart-operator
        smartparens
        smooth-scrolling
        ssh
        undo-tree
        yasnippet
        ))

(let ((local-init (format "~/.emacs.d/init-%s.el"
                          (car (split-string system-name "\\.")))))
  (if (file-exists-p local-init)
      (load local-init)))

(el-get-cleanup my:el-get-packages)
(el-get 'sync my:el-get-packages)

(require 'init-loader)
(setq init-loader-byte-compile t)
(init-loader-load "~/.emacs.d/inits")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(proof-active-area-face ((t (:background "cyan"))))
 '(proof-locked-face ((t (:background "color-77"))))
 '(proof-queue-face ((t (:background "color-246")))))
