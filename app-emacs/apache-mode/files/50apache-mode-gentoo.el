
;;; apache-mode site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(autoload 'apache-mode "apache-mode" "autoloaded" t)
(add-to-list 'auto-mode-alist '("\\.htaccess$"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf$"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf$"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf$" . apache-mode))
(add-to-list 'auto-mode-alist '("apache[12]\?\\.conf$" . apache-mode))
(add-to-list 'auto-mode-alist '("commonapache[12]\?\\.conf$" . apache-mode))
