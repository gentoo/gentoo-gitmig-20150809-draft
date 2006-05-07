
;;; cdi site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'cdi-start "cdi" "Setup the cdi buffer and perhaps start a daemon." t)
