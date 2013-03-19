; setup el-get and MELPA

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(setq package-archives
      (cons '("melpa" . "http://melpa.milkbox.net/packages/")
            package-archives))

(setq my:el-get-packages
      '(
        el-get
        evil
        full-ack
        js2-mode
        lorem-ipsum
        markdown-mode
        rainbow-delimiters
        ssh
        undo-tree
        yasnippet
        ))

(setq el-get-sources
      '(
        (:name amd-mode
               :type github
               :pkgname "hendrikvanantwerpen/amd-mode.el")
        (:name css-mode
               :type elpa)
        (:name dash
               :type elpa)
        (:name js2-refactor
               :type github
               :pkgname "magnars/js2-refactor.el"
               :depends (js2-mode dash multiple-cursors s))
        (:name multiple-cursors
               :type elpa)
        (:name less-css-mode
               :type elpa)
        (:name load-dir
               :type elpa)
        (:name s
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
                                      (amd-mode)
                                      (js2-refactor))))
(add-hook 'js2-post-parse-callbacks
          (lambda () (progn (add-to-list 'js2-additional-externs "define")
                            (add-to-list 'js2-additional-externs "require"))))

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)
