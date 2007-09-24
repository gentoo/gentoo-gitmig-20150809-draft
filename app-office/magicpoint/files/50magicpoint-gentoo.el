;;; magicpoint site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'mgp-mode "mgp-mode" "MagicPoint editor mode" t)
(setq auto-mode-alist (cons '("\\.mgp$" . mgp-mode) auto-mode-alist))
