
;;; table site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(require 'table)
(add-hook 'text-mode-hook 'table-recognize)

