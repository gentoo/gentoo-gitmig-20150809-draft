;;; doxymacs site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(add-hook 'c-mode-common-hook (load "doxymacs" nil t))
