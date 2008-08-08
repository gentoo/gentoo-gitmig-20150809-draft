
;;; bongo site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(add-to-list 'image-load-path "@SITEETC@" t)
(autoload 'bongo "bongo" "Start Bongo by switching to a Bongo buffer." t)
