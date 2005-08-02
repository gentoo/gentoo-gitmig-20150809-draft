;;; gwydion-dylan site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'dylan-mode "dylan-mode" "Dylan-mode" t)
(setq auto-mode-alist (cons '("\\.dylan\\'" . dylan-mode) auto-mode-alist))
