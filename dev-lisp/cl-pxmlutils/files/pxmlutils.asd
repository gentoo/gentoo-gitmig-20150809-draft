;;;; -*- lisp -*-

;; This is the same as the ASDF as the one distributed with pxmlutils.
;; The only difference is that phtml.cl has been omitted
;; (dev-lisp/cl-phtml already provides this from the Portable Allegro
;; Server project) -- Matthew Kennedy <mkennedy@gentoo.org>

(defpackage :pxmlutils.system
  (:use :common-lisp
        :asdf))

(in-package :pxmlutils.system)

(defclass file.cl (cl-source-file)
  ())

(defmethod source-file-type ((f file.cl) (m module))
  (declare (ignore f m))
  "cl")

(defsystem :pxmlutils
    :components ((:file.cl "pxml0")
		 (:file.cl "pxml1" :depends-on ("pxml0"))
		 (:file.cl "pxml2" :depends-on ("pxml1"))
		 (:file.cl "pxml3" :depends-on ("pxml2")))
    :depends-on (:acl-compat))
