
;;; matlab site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)

(autoload 'tlc-mode "tlc" "tlc Editing Mode" t)
(add-to-list 'auto-mode-alist '("\\.tlc$" . tlc-mode))
(setq tlc-indent-function t)
