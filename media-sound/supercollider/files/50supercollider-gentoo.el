
;;; pspp site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'sclang-mode "sclang" nil t)
(add-to-list 'auto-mode-alist '("\\.sc\\'" . sclang))
