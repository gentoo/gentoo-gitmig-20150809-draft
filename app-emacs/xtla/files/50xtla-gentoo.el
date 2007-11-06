
;;; xtla site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(if (featurep 'xtla)
    (tla-reload)
  (require 'xtla-autoloads))
