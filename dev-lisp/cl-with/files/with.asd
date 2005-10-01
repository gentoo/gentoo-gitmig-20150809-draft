
(defpackage #:with-system
  (:use #:common-lisp
	#:asdf))

(in-package #:with-system)

(defsystem #:with
    :name "WITH"
    :components ((:file "with-package")
		 (:file "with" :depends-on ("with-package")))
    :depends-on (#:cl-plus))
