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
        auto-complete
        auto-complete-css
        auto-complete-emacs-lisp
        auto-complete-latex
        auto-complete-yasnippet
        auctex
        css-mode
        el-get
        evil
        full-ack
        js2-mode
        js2-refactor
        json
        load-dir
        lorem-ipsum
        markdown-mode
        python-mode
        rainbow-delimiters
        ssh
        undo-tree
        yasnippet
        ))

(setq el-get-sources
      '(
        (:name semver
               :type github
               :pkgname "hendrikvanantwerpen/semver.el"
               :depends (dash s))
        (:name js-pkg
               :type github
               :pkgname "hendrikvanantwerpen/js-pkg.el"
               :depends (dash s semver json))
        (:name amd-mode
               :type github
               :pkgname "hendrikvanantwerpen/amd-mode.el"
               :depends (dash js-pkg semver))
        (:name less-css-mode
               :type elpa)
        (:name load-dir
               :type elpa)
        ))

(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my:el-get-packages)

; misc basic stuff
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq split-width-threshold 100)
(show-paren-mode t)

(require 'desktop)
(setq desktop-restore-eager t)
(desktop-save-mode t)

(require 'undo-tree)
(global-undo-tree-mode t)

(require 'evil)
(setq evil-default-state 'normal)
(setq evil-shift-width 4)
(setq-default evil-auto-indent t)
(setq evil-want-visual-char-semi-exclusive t)
(define-key evil-normal-state-map (kbd "TAB") 'other-window)
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

; Javascript
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'load-path "~/.emacs.d/amd-mode/")
(require 'amd-mode)
(require 'js2-refactor)
(add-hook 'js2-mode-hook (lambda () (progn
                                      (amd-mode))))
(add-hook 'js2-post-parse-callbacks
          (lambda () (progn (add-to-list 'js2-additional-externs "define")
                            (add-to-list 'js2-additional-externs "require"))))

(require 'python-mode)

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)
