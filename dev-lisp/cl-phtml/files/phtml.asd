;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-

(defpackage #:phtml-system
  (:use #:cl #:asdf))
(in-package #:phtml-system)

(in-package :phtml-system)

(defclass acl-file (cl-source-file) ())

(defmethod asdf::source-file-type ((c acl-file) (s module)) 
  "cl")

(defsystem phtml
    :depends-on (acl-compat)
    :components ((:acl-file "phtml")))
