
;;; analog site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'analog "analog" 
  "Start analog mode"
  t)
