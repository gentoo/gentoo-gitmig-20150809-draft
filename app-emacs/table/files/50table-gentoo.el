
;;; table site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(require 'table)
(add-hook 'text-mode-hook 'table-recognize)

