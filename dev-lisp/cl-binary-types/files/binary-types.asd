;;;; -*- Mode: LISP; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defpackage binary-types-system 
  (:use :asdf :common-lisp))

(in-package :binary-types-system)

(defsystem binary-types
    :name "cl-binary-types"
    :author "Frode Vatvedt Fjeld <frodef@acm.org>"
    :perform (load-op :after (op binary-types)
		      (pushnew :binary-types cl:*features*))
    :components ((:file "binary-types")))

;; binary-types.asd ends here
