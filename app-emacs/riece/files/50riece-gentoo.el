;;; riece site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'riece "riece" "Start riece." t)
