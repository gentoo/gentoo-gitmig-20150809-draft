
;;; hyperspec site-lisp configuration

;; this code is right out of the corresponing package in debian

(add-hook 'ilisp-load-hook
          (function
           (lambda ()
             ;; Set a keybinding for the COMMON-LISP-HYPERSPEC command
             (defkey-ilisp [(control f1)] 'common-lisp-hyperspec)
             (message "Running ilisp-load-hook")
             (setq common-lisp-hyperspec-root "/usr/share/doc/@HYPERSPEC@/")
             (setq common-lisp-hyperspec-symbol-table
                   (concat common-lisp-hyperspec-root "Data/Map_Sym.txt")))))
