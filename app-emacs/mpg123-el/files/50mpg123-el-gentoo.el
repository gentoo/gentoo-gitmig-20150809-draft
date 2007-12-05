
;;; mpg123-el site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'mpg123 "mpg123" "A Front-end to mpg123" t)
(setq id3*put-prog "tagput")
