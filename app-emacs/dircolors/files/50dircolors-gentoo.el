
;;; dircolors site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(require 'dircolors)
(add-hook 'completion-list-mode-hook 'dircolors)

