
;;; erc site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'erc-select "erc" 
  "Start erc."
  t)
