
;;; inform-mode site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(autoload 'inform-mode "inform-mode" "Inform editing mode." t)
(autoload 'inform-maybe-mode "inform-mode" "Inform/C header editing mode.")

(setq auto-mode-alist
      (append '(("\\.h\\'"   . inform-maybe-mode)
                ("\\.inf\\'" . inform-mode))
              auto-mode-alist))
