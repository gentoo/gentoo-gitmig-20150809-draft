
;;; gnuplot-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
;; extracted from dotemacs file distributed with the source tarball
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)
(setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))
(global-set-key [(f9)] 'gnuplot-make-buffer)

