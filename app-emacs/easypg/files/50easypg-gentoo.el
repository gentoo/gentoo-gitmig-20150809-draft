;; Emacs 23 and later include easypg
(unless (fboundp 'epa-file-handler)
  (add-to-list 'load-path "@SITELISP@")
  (load "easypg-autoloads" nil t))
