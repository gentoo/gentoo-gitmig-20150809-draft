
;;; mew site-lisp configuration
(add-to-list 'load-path "@SITELISP@")

(setq mew-icon-directory "/usr/share/mew")

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
