
;;; rst site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'rst-mode "rst" "mode for editing reStructuredText documents" t)
(add-to-list 'auto-mode-alist '("\\.re?st\\'" . rst-mode))

;; disable rst-mode-lazy in case font-lock doesn't support it
(or (fboundp 'lazy-lock-mode)
    (setq rst-mode-lazy nil))
