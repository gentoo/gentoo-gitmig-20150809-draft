;;; mew site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(setq mew-icon-directory "/usr/share/mew")

(setq mew-pop-port "pop-3")
(setq mew-imap-port "imap2")

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)


