;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;; *************************************************************************
;;;; FILE IDENTIFICATION
;;;;
;;;; Name:          uffi.asd
;;;; Purpose:       ASDF system definition file for UFFI package
;;;; Author:        Kevin M. Rosenberg
;;;; Date Started:  Aug 2002
;;;;
;;;; $Id: uffi.asd,v 1.1 2003/06/10 04:53:04 mkennedy Exp $
;;;;
;;;; This file, part of UFFI, is Copyright (c) 2002 by Kevin M. Rosenberg
;;;;
;;;; UFFI users are granted the rights to distribute and use this software
;;;; as governed by the terms of the Lisp Lesser GNU Public License
;;;; (http://opensource.franz.com/preamble.html), also known as the LLGPL.
;;;; *************************************************************************

(defpackage #:uffi-system (:use #:asdf #:cl))
(in-package #:uffi-system)

#+(or allegro lispworks cmu mcl cormanlisp sbcl scl)
(defsystem uffi
  :name "uffi"
  :author "Kevin Rosenberg <kevin@rosenberg.net>"
  :version "1.2.x"
  :maintainer "Kevin M. Rosenberg <kmr@debian.org>"
  :licence "Lessor Lisp General Public License"
  :description "Universal Foreign Function Library for Common Lisp"
  :long-description "UFFI provides a universal foreign function interface (FFI) for Common Lisp. UFFI supports CMUCL, Lispworks, and AllegroCL."
  
  :components
	    ((:file "package")
	     (:file "primitives" :depends-on ("package"))
	     #+mcl (:file "readmacros-mcl" :depends-on ("package"))
	     (:file "strings" :depends-on ("primitives"))
	     (:file "objects" :depends-on ("primitives"))
	     (:file "aggregates" :depends-on ("primitives"))
	     (:file "functions" :depends-on ("primitives"))
	     (:file "libraries" :depends-on ("package"))
	     (:file "os" :depends-on ("package"))))

#+(or allegro lispworks cmu mcl cormanlisp sbcl scl)
(defmethod perform ((o test-op) (c (eql (find-system :uffi))))
  (oos 'load-op 'uffi-tests)
  (oos 'test-op 'uffi-tests))


