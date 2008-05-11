
;;; mew site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(setq mew-icon-directory "/usr/share/mew")
(setq mew-pop-port "pop-3")
(setq mew-imap-port "imap2")

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
