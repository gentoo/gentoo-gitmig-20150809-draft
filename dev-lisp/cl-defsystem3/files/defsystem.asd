(defpackage defsystem-system (:use #:common-lisp #:asdf))
(in-package #:defsystem-system)
(defsystem #:defsystem :components ((:file "defsystem")))
