
;;; nxml site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(load "@SITELISP@/rng-auto.el")

(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
	        auto-mode-alist))
