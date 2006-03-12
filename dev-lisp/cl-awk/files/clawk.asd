(defpackage #:clawk-system (:use #:common-lisp #:asdf))
(in-package #:clawk-system)

(defsystem #:clawk
  :depends-on (#:regex #:cl-plus)
  :components ((:file "packages")
               (:file "clawk" :depends-on ("packages"))))
