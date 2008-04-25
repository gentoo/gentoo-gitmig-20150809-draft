
;;; moccur-edit site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(eval-after-load "color-moccur"
  '(require 'moccur-edit))
