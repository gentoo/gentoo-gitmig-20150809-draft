
;;; liece site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(setq liece-intl-catalogue-directory "/usr/share/liece/locale"
      liece-window-style-directory "/usr/share/liece/styles"
      liece-icon-directory "/usr/share/liece/icons")
(autoload 'liece "liece" 
  "Start liece."
  t)
