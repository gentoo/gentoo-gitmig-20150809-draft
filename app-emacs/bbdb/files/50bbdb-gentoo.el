
;;; bbdb site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(setq load-path (cons "@SITELISP@/bits" load-path))
(require 'bbdb)
(bbdb-initialize)

