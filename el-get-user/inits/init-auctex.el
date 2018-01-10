(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-fold-mode t)
(setq TeX-save-query nil)
(setq TeX-source-correlate-mode t)
(setq TeX-output-view-style
      '(("html" "^html$" "x-www-browser %o")
        ("pdf" "^pdf$" "evince %o")))
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'fill-nobreak-predicate 'texmathp)
            (add-to-list 'fill-nobreak-predicate 'lst-nobreak-p)
            (visual-line-mode)
            (flyspell-mode)
            (flyspell-buffer)
            (LaTeX-math-mode)))

;; this uses a heuristic to prevent breaking inline code
;; any macro ending in inline with weird delimiters won't be broken
(defun lst-nobreak-p ()
  (or (and (looking-at "[^\|]*\|")
           (looking-back "\\\w+inline\|[^\|]*"))
      (and (looking-at "[^!]*!")
           (looking-back "\\\w+inline![^!]*"))
      (and (looking-at "[^<]*>")
           (looking-back "\\\w+inline<[^>]*"))))
