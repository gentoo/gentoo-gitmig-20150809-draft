
;;; inform-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'inform-mode "inform-mode" "Inform editing mode." t)
(autoload 'inform-maybe-mode "inform-mode" "Inform/C header editing mode.")

(setq auto-mode-alist
      (append '(("\\.h\\'"   . inform-maybe-mode)
                ("\\.inf\\'" . inform-mode))
              auto-mode-alist))
