
;;; site-lisp configuration for simple-wiki

(add-to-list 'load-path "@SITELISP@")
(require 'simple-wiki-completion)

;;; The following are an attempt at some reasonable defaults based on
;;; the EmacsWiki page:
;;; http://emacswiki.org/cgi-bin/wiki.pl?SimpleWikiEditMode

;; (add-hook 'simple-wiki-edit-mode-hooks 'pcomplete-simple-wiki-setup)
;; (add-hook 'simple-wiki-edit-mode-hooks 'turn-off-auto-fill)
