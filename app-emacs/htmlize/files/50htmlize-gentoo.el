
;;; htmlize site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'htmlize-file "htmlize"
htmlize-many-files
htmlize-many-files-dired