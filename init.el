; setup el-get and MELPA

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve
     "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
     (lambda (s)
             (let (el-get-master-branch)
                  (goto-char (point-max))
                  (eval-print-last-sexp))))))

(setq my:el-get-packages
      '(
        ac-math
        ac-python
        amd-mode
        ;auctex --- install crashes
        auto-complete
        auto-complete-css
        auto-complete-emacs-lisp
        auto-complete-latex
        auto-complete-yasnippet
        autopair
        el-get
        evil
        full-ack
        js-pkg
        js2-mode
        js2-refactor
        json
        load-dir
        lorem-ipsum
        markdown-mode
        python-mode
        rainbow-delimiters
        semver
        smart-operator
        smartparens
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
(define-key evil-normal-state-map (kbd "TAB") 'other-window)
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(smartparens-global-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun simple-tabs-mode ()
  "Bind TAB to simple tabs, instead of whatever indent function is active."
  (interactive)
  (setq indent-line-function 'insert-tab))

(defun truncate-mode ()
  "Enable line truncation for this buffer."
  (interactive)
  (setq truncate-lines t))
