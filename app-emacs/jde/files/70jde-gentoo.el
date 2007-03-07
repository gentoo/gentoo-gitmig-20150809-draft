
;;; JDE site-lisp configuration

(add-to-list 'load-path "@SITELISP@/lisp")
(autoload 'jde-mode "jde" "Java Development Environment Emacs" t)
(setq auto-mode-alist (cons '("\\.java$" . jde-mode) auto-mode-alist))
