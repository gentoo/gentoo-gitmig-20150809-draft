
;;; mu-cite Gentoo site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'mu-cite-original "mu-cite" nil t)
(add-hook 'mail-citation-hook (function mu-cite-original))
