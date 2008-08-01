
;;; slime site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(require 'slime)
(slime-setup)

;; this allows us not to require dev-lisp/hyperspec
;; (which is non-free) as a hard dependency
(setq common-lisp-hyperspec-root
      (if (file-exists-p "/usr/share/doc/hyperspec/HyperSpec")
	  "file:///usr/share/doc/hyperspec/HyperSpec/"
	"http://www.lispworks.com/reference/HyperSpec/"))
