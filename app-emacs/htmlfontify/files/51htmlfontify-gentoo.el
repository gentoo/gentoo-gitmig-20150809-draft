
;;; htmlfontify site-lisp configuration
(add-to-list 'load-path "@SITELISP@")
(autoload 'htmlfontify-buffer "htmlfontify" nil t)
(autoload 'htmlfontify-run-etags "htmlfontify" nil t)
(autoload 'htmlfontify-copy-and-link-dir "htmlfontify" nil t)
(autoload 'htmlfontify-load-rgb-file "hfy-cmap" nil t)
(autoload 'htmlfontify-unload-rgb-file "hfy-cmap" nil t)
