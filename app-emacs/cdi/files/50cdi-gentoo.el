
;;; cdi site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'cdi-start "cdi"
  "Start the CDI interface"
  t)
