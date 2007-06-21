;;; site-lisp configuration for ebuild-mode

(add-to-list 'load-path "@SITELISP@")

(autoload 'ebuild-mode "ebuild-mode" "Major mode for Portage .ebuild and .eclass files." t)
(autoload 'eselect-mode "ebuild-mode" "Major mode for Portage .eselect files." t)

(add-to-list 'auto-mode-alist '("\\.ebuild\\'" . ebuild-mode))
(add-to-list 'auto-mode-alist '("\\.eclass\\'" . ebuild-mode))
(add-to-list 'auto-mode-alist '("\\.eselect\\'" . eselect-mode))
(add-to-list 'interpreter-mode-alist '("runscript" . sh-mode))
