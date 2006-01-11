;; ses site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'ses-mode "ses" nil t)
(add-to-list 'auto-mode-alist '("\\.ses\\'" . ses-mode))

