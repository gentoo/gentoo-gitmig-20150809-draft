;;; -*- mode: lisp; syntax: common-lisp; base: 10; package: common-lisp-user -*-

(in-package #:common-lisp-user)

(defpackage #:prevalence-system
  (:use #:asdf #:common-lisp))

(in-package #:prevalence-system)

(defsystem #:prevalence
  :author "Matthew Kennedy <mkennedy@gentoo.org>"
  :licence "LLGPL-2.1"
  :components
  ((:file "serialization")
   (:file "prevalence" :depends-on ("serialization")))
  :depends-on (:xml))

