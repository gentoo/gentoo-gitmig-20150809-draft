
;;; junkbust site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(require 'junkbust)
(global-set-key   [f6] 'junkbust-block-url-edit-rule)
(global-set-key [S-f6] 'junkbust-block-url-edit-url)
(global-set-key [C-f6] 'junkbust-blocklist-file-visit)
