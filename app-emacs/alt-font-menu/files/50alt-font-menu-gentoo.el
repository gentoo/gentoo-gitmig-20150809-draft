
;;; site-lisp configuration for alt-font-menu

(add-to-list 'load-path "@SITELISP@")
(autoload 'alt-mouse-set-font "alt-font-menu"
  "interactively choose font using mouse" t)
(global-set-key [(shift down-mouse-1)] 'alt-mouse-set-font)
