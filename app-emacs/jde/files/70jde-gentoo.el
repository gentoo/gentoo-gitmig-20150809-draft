
;;; JDE site-lisp configuration

(setq load-path (cons "@SITELISP@/lisp" load-path))
(autoload 'jde-mode "jde" "Java Development Environment Emacs" t)
(setq auto-mode-alist (cons '("\\.java$" . jde-mode) auto-mode-alist))
