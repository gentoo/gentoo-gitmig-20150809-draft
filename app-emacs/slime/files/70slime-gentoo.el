
;;; site-lisp configuration for slime-cvs

(add-to-list 'load-path "@SITELISP@")
(require 'slime)
(slime-setup)

;; this prevents us from requiring the user get dev-lisp/hyperspec
;; (which is non-free) as a hard dependency

(if (file-exists-p "/usr/share/doc/hyperspec/HyperSpec")
    (setq common-lisp-hyperspec-root "file:///usr/share/doc/hyperspec/HyperSpec/")
  (setq common-lisp-hyperspec-root "http://www.lispworks.com/reference/HyperSpec/"))
