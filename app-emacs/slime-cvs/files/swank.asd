;;; -*- mode: lisp; syntax: common-lisp; base: 10; package: common-lisp-user -*-

(in-package #:common-lisp-user)

(defpackage #:swank-system
  (:use #:asdf
	#:common-lisp))

(in-package #:swank-system)

(defsystem #:swank
  :name "Swank is the Common Lisp back-end to Slime"
  :author "Matthew Kennedy <mkennedy@gentoo.org>"
  :maintainer "Matthew Kennedy <mkennedy@gentoo.org>"
  :licence "GPL-2"
  :components ((:file "swank")
	       (:file "null-swank-impl" :depends-on ("swank"))
	       #+cmu (:file "swank-cmucl" :depends-on ("null-swank-impl"))
	       #+sbcl (:file "swank-sbcl" :depends-on ("null-swank-impl"))))
