
;;; ocaml-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(setq auto-mode-alist
    (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
(require 'caml-font)
