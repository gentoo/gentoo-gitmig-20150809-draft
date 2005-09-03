
;;; flashcard site-lisp configuration 

(add-to-list 'load-path "@SITELISP@")
(add-to-list 'auto-mode-alist '("\\.deck\\'" . flashcard-mode))
(autoload 'flashcard-import-from-colon-file
  "flashcard"
  "Autoload for `flashcard-import-from-colon-file'."
  t)
