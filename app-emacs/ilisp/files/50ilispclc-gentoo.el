
;;; ilisp site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(setq load-path (cons "@SITELISP@/extra" load-path))
(load "/etc/ilisp/ilisp.el")
