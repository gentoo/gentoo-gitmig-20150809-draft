
;;; site-lisp configuration for slime-cvs

(add-to-list 'load-path "@SITELISP@")
(require 'slime)
(add-hook 'lisp-mode-hook
	  (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook
	  (lambda () (inferior-slime-mode t)))

;; this prevents us from requiring the user get dev-lisp/hyperspec
;; (which is non-free) as a hard dependency

(if (file-exists-p "/usr/share/doc/hyperspec/HyperSpec")
    (setq common-lisp-hyperspec-root "file:///usr/share/doc/hyperspec/HyperSpec/")
  (setq common-lisp-hyperspec-root "http://www.lispworks.com/reference/HyperSpec/"))
