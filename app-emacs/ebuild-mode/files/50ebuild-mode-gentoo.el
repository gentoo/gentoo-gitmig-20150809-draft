;;; site-lisp configuration for ebuild-mode

(add-to-list 'load-path "@SITELISP@")

(add-to-list 'auto-mode-alist '("\\.ebuild\\'" . ebuild-mode))
(add-to-list 'auto-mode-alist '("\\.eclass\\'" . ebuild-mode))
(add-to-list 'auto-mode-alist '("\\.eselect\\'" . eselect-mode))
