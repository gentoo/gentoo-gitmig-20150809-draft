
;;; dictionary site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(load "dictionary-init")

(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)
