
;;; table site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(load "table-autoloads" nil t)
(add-hook 'text-mode-hook 'table-recognize)
