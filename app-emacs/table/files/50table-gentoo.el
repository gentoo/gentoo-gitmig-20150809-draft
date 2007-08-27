
;;; table site-lisp configuration

;; Emacs 22 and later include the table package
(unless (fboundp 'table-insert)
  (add-to-list 'load-path "@SITELISP@")
  (load "table-autoloads" nil t)
  (add-hook 'text-mode-hook 'table-recognize))
