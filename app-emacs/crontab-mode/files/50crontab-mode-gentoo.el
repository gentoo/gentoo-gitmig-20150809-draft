
;;; crontab-mode site-lisp configuration 

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'crontab-mode "crontab-mode" nil t)
(autoload 'crontab-get "crontab-mode" nil t)

