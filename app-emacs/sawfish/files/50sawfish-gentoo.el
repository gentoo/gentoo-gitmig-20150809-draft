
;;; elscreen site-lisp configuration 

(add-to-list 'load-path "@SITELISP@")
(autoload 'sawfish-mode "sawfish" "Autoload for sawfish-mode" t)
(autoload 'sawfish-interaction "sawfish" "Autoload for sawfish-interaction" t)
(autoload 'sawfish-console "sawfish" "Autoload for sawfish-console" t)
(setq auto-mode-alist (cons '("\\.sawfishrc$"  . sawfish-mode) auto-mode-alist)
      auto-mode-alist (cons '("\\.jl$"         . sawfish-mode) auto-mode-alist)
      auto-mode-alist (cons '("\\.sawfish/rc$" . sawfish-mode) auto-mode-alist))
