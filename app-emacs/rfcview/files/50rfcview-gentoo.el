
;;; site-lisp configuration for rfcview

(add-to-list 'load-path "@SITELISP@")
(setq auto-mode-alist
      (cons '("/rfc[0-9]+\\.txt\\(\\.gz\\)?\\'" . rfcview-mode)
	    auto-mode-alist))
(autoload 'rfcview-mode "rfcview" nil t)
