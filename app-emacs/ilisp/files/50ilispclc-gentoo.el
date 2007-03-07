
;;; ilisp site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(add-to-list 'load-path "@SITELISP@/extra")
(load "/etc/ilisp/ilisp.el")

(add-hook 'ilisp-load-hook
	  (function
	   (lambda ()
	     ;; Set a keybinding for the COMMON-LISP-HYPERSPEC command
	     (defkey-ilisp [(control f1)] 'common-lisp-hyperspec)
	     (message "Running ilisp-load-hook")
	     (if (file-exists-p "/usr/share/doc/hyperspec-6.0/HyperSpec")
		 (progn
		   (setq common-lisp-hyperspec-root "file:///usr/share/doc/hyperspec-6.0/HyperSpec/")
		   (setq common-lisp-hyperspec-symbol-table (concat common-lisp-hyperspec-root "Data/Map_Sym.txt")))
	       (setq common-lisp-hyperspec-root "http://www.lispworks.com/reference/HyperSpec/")))))


