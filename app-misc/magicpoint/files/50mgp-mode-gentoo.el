;;; mgp-mode site-lisp configuration

(autoload 'mgp-mode "mgp-mode" "MagicPoint editor mode" t)
(setq auto-mode-alist (cons '("\\.mgp$" . mgp-mode) auto-mode-alist))
