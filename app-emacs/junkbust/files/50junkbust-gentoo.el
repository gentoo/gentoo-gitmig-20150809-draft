
;;; junkbust site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(require 'junkbust)
(global-set-key   [f6] 'junkbust-block-url-edit-rule)
(global-set-key [S-f6] 'junkbust-block-url-edit-url)
(global-set-key [C-f6] 'junkbust-blocklist-file-visit)
