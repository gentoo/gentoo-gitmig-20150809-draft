;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;; *************************************************************************
;;;; FILE IDENTIFICATION
;;;;
;;;; Name:          uffi-tests.asd
;;;; Purpose:       ASDF system definitionf for uffi testing package
;;;; Author:        Kevin M. Rosenberg
;;;; Date Started:  Apr 2003
;;;;
;;;; $Id: uffi-tests.asd,v 1.1 2003/06/10 04:53:04 mkennedy Exp $
;;;; *************************************************************************

(defpackage #:uffi-tests-system
  (:use #:asdf #:cl))
(in-package #:uffi-tests-system)

(defsystem uffi-tests
    :depends-on (:uffi)
    :components
	      ((:file "rt")
	       (:file "package" :depends-on ("rt"))
	       (:file "strtol" :depends-on ("package"))
	       (:file "atoifl" :depends-on ("package"))
	       (:file "getenv" :depends-on ("package"))
	       (:file "gethostname" :depends-on ("package"))
	       (:file "union" :depends-on ("package"))
	       (:file "arrays" :depends-on ("package"))
	       (:file "time" :depends-on ("package"))
	       (:file "foreign-loader" :depends-on ("package"))
	       (:file "compress" :depends-on ("foreign-loader"))
	       (:file "uffi-c-test-lib" :depends-on ("foreign-loader"))
	       ))

(defmethod perform ((o test-op) (c (eql (find-system :uffi-tests))))
  (or (funcall (intern (symbol-name '#:do-tests)
		       (find-package '#:regression-test)))
      (error "test-op failed")))
