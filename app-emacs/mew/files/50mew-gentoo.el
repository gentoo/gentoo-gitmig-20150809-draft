
;;; mew site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(setq mew-icon-directory "/usr/share/mew")

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
