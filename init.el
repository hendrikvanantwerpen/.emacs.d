; setup el-get and MELPA

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(setq my:el-get-packages
      '(
        ac-ghc-mod
        ac-js2
        ac-math
        ac-python
        amd-mode
        auctex
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
        evil
        flyspell
        full-ack
        haskell-mode
        js-pkg
        js2-mode
        js2-refactor
        json
        load-dir
        lorem-ipsum
        markdown-mode
        python-mode
        rainbow-delimiters
        reftex
        scala-mode2
        semver
        smart-operator
        smartparens
        sbt-mode
        ssh
        undo-tree
        yasnippet
        ))

(setq el-get-sources
      '(
        (:name semver
               :type github
               :pkgname "hendrikvanantwerpen/semver.el"
               :depends (s))
        (:name js-pkg
               :type github
               :pkgname "hendrikvanantwerpen/js-pkg.el"
               :depends (json s semver))
        (:name amd-mode
               :type github
               :pkgname "hendrikvanantwerpen/amd-mode.el"
               :depends (js2-mode js-pkg semver auto-complete dash s ))
        (:name ebib
               :type github
               :pkgname "hendrikvanantwerpen/ebib"
               :depends (parsebib))
        (:name less-css-mode
               :type elpa)
        (:name load-dir
               :type elpa)
        ))

(el-get 'sync my:el-get-packages)

; tabs
(setq-default indent-tabs-mode nil) ; no tabs please
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 200 4))

; windows
(setq split-width-threshold 100) ; prefer horizontal splits
(define-key input-decode-map "\e[1;2A" [S-up]) ; fix xterm/console problem
(windmove-default-keybindings)
(winner-mode t)

; parens highlighting on
(smartparens-global-mode t)
(show-paren-mode t) ; highlight parens matches

; full-ack
(setq ack-executable (executable-find "ack-grep"))

(require 'undo-tree)
(global-undo-tree-mode t)

(require 'evil)
(setq evil-default-state 'normal)
(setq evil-shift-width 4)
(setq-default evil-auto-indent t)
(setq evil-want-visual-char-semi-exclusive t)
(define-key evil-normal-state-map (kbd "<backtab>")
  (lambda () (interactive) (other-window -1)))
(define-key evil-normal-state-map "H" 'evil-next-buffer)
(define-key evil-normal-state-map "L" 'evil-prev-buffer)
(define-key evil-motion-state-map [prior] 'evil-scroll-page-up)
(define-key evil-motion-state-map [next] 'evil-scroll-page-down)
(evil-mode 1)

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

(require 'linum)
(setq linum-format "%3d ")
(global-linum-mode t)
(setq line-number-mode t)
(setq column-number-mode t)

(require 'smartparens-config)
(smartparens-global-mode 1)

(require 'auto-complete-config)
(ac-config-default)
(ac-set-trigger-key "TAB")

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(require 'js2-refactor)
;(setq load-path (cons "~/prog/amd-mode.el/" load-path))
(require 'amd-mode)
(require 'ac-amd)
(add-hook 'js2-mode-hook
          (lambda ()
            (setq ac-sources nil)
            (amd-mode)
            (ac-amd-setup)
            (auto-complete-mode)))
(add-hook 'js2-post-parse-callbacks
          (lambda() 
            (amd-externs-setup)))

(require 'amd-dojo-plugins)
(amd-dojo-plugins-setup)

(require 'ac-amd-dojo-completions)
(ac-amd-dojo-completions-setup)

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)

; AucTeX
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq-default TeX-master nil)
(setq TeX-output-view-style
  '((("^pdf$" "." "evince build/%o")
     ("^html?$" "." "x-www-browser build/%o"))))
;(setq TeX-source-correlate-mode t)
(setq TeX-command-extra-options "-output-directory=build/")
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

; Flyspell
(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")

; ebib
(evil-set-initial-state 'ebib-entry-mode 'emacs)
(evil-set-initial-state 'ebib-index-mode 'emacs)
(evil-set-initial-state 'ebib-log-mode 'emacs)
(defun ebib-multiline-evil-hook ()
  (setq-local evil-ex-commands nil)
  (evil-add-to-alist 'evil-ex-commands "wq" 'ebib-quit-multiline-edit-and-save)
  (evil-add-to-alist 'evil-ex-commands "q" 'ebib-cancel-multiline-edit)
  (evil-add-to-alist 'evil-ex-commands "quit" "q")
  (evil-add-to-alist 'evil-ex-commands "w" 'ebib-save-from-multiline-edit)
  (evil-add-to-alist 'evil-ex-commands "write" "w")
  (evil-add-to-alist 'evil-ex-commands "h" 'ebib-multiline-help)
  (evil-add-to-alist 'evil-ex-commands "help" "h"))
(add-hook 'ebib-multiline-mode-hook 'ebib-multiline-evil-hook)

; HideShow / code folding
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

(when (require 'agda2-mode nil t)
  (defun my-agda2-mode-hook ()
    "Modify keys and input-mode for agda mode"
    (local-set-key (kbd "C-c .") 'agda2-goal-and-context-and-inferred)
    (local-set-key (kbd "C-c ,") 'agda2-goal-and-context)
    (local-set-key (kbd "C-c ?") 'agda2-show-goals)
    (local-set-key (kbd "C-c =") 'agda2-show-constraints)
    (local-set-key (kbd "C-c C-@") 'agda2-give)
    (add-hook 'evil-insert-state-entry-hook
              (lambda () (set-input-method "Agda")))
    (add-hook 'evil-insert-state-exit-hook
              (lambda () (set-input-method nil))))
  (add-hook 'agda2-mode-hook 'my-agda2-mode-hook))

(defun simple-tabs-mode ()
  "Bind TAB to simple tabs, instead of whatever indent function is active."
  (interactive)
  (if (local-variable-if-set-p 'my-prev-indent-line-function)
      (progn (setq-local indent-line-function my-prev-indent-line-function)
             (setq-local my-prev-indent-line-function nil)
             (message "Simple tabs mode is off"))
    (setq-local my-prev-indent-line-function indent-line-function)
    (setq-local indent-line-function 'insert-tab)
    (message "Simple tabs mode is on")))

(defun truncate-mode ()
  "Enable line truncation for this buffer."
  (interactive)
  (if truncate-lines
      (progn (setq-local truncate-lines nil)
             (message "Truncate mode is off"))
    (setq-local truncate-lines t)
    (message "Truncate mode is on")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ebib-bib-search-dirs (quote ("~/edu/library")))
 '(ebib-file-associations (quote (("pdf" . "evince") ("ps" . "evince"))))
 '(ebib-file-search-dirs nil)
 '(ebib-preload-bib-files (quote ("library.bib"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
