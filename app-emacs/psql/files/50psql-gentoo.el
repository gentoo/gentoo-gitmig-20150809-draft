
;;; psql site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'psql-mode "psql-mode" "Mode for editing postgress sql." t)
(autoload 'psql-run  "psql-mode" "Mode for editing postgress sql." t)
(add-to-list 'auto-mode-alist '("\\.p?sql$" . psql-mode ))
