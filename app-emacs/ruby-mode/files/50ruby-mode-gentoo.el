;;; Ruby-mode site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(autoload 'ruby-mode "ruby-mode" "Major mode to edit ruby files." t)
(setq auto-mode-alist
  (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))


