
;;; bbdb site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(require 'bbdb)
(bbdb-initialize)

