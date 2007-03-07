
;;; dircolors site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(require 'dircolors)
(add-hook 'completion-list-mode-hook 'dircolors)

