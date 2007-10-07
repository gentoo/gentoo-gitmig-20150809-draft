
;;; cdrw site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'cdrw "cdrw" "CDRW Creation" t)
(autoload 'cdrw-from-file "cdrw" "Load previously saved mark-file." t)
