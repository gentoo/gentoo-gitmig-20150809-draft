
;;; semantic site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(require 'semantic-util)
(setq semantic-load-turn-everything-on t)
(require 'semantic-load)
