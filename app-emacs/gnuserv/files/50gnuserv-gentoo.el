
;;; gnuserv site-lisp configuration

(setq load-path (cons (concat "@SITELISP@") load-path))
;; necessary for FSF GNU Emacs only
(autoload 'gnuserv-start "gnuserv-compat"
  "Allow this Emacs process to be a server for client processes." t)
