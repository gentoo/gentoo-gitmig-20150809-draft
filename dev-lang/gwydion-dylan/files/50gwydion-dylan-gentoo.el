
;;; gwydion-dylan site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'dylan-mode "dylan-mode" "Dylan-mode" t)
(add-to-list 'auto-mode-alist '("\\.dylan\\'" . dylan-mode))
