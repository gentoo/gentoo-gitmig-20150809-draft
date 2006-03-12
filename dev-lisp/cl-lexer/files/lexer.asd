(defpackage #:lexer-system (:use #:common-lisp #:asdf))
(in-package #:lexer-system)

(defsystem #:lexer
  :depends-on (#:regex)
  :components ((:file "packages")
               (:file "lexer" :depends-on ("packages"))))
