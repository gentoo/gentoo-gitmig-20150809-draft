
;; edb site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'db-find-file "database" "EDB database package" t)
(autoload 'edb-EXPERIMENTAL-interact "EDB database package" t)
