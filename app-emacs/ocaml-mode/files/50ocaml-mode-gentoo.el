
;;; ocaml-mode site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(setq auto-mode-alist
    (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
(require 'caml-font)
