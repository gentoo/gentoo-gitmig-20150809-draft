;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-

(defpackage #:pxml-system
  (:use #:cl #:asdf))
(in-package #:pxml-system)

(in-package :pxml-system)

(defclass acl-file (cl-source-file) ())

(defmethod asdf::source-file-type ((c acl-file) (s module)) 
  "cl")

(defsystem pxml
    :depends-on (acl-compat)
    :components ((:acl-file "pxml0")
		 (:acl-file "pxml1")
		 (:acl-file "pxml2")
		 (:acl-file "pxml3")))
