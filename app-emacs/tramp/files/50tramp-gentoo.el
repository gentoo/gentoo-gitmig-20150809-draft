
;;; tramp site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(setq auto-save-file-name-transforms
      `(("\\`/[^/]*:\\(.+/\\)*\\(.*\\)"
	 ,(expand-file-name "\\2" temporary-file-directory))))
(require 'tramp)
