;;; -*- mode: lisp; syntax: common-lisp; package: cl-user -*-

;; This file is NOT part of SLIME.

;; This file is provided by the Gentoo port to load swank via an the
;; ASDF system (rather than using swank's own system).  This file is
;; constucted from the knowledge encapsulated in SLIME's original
;; swank-loader.lisp.
;;
;; Matthew Kennedy <mkennedy@gentoo.org>

(defpackage #:swank-system
  (:use #:common-lisp
        #:asdf))

(in-package #:swank-system)

;; http://www.caddr.com/macho/archives/sbcl-devel/2004-3/3014.html

(defclass unsafe-file (cl-source-file) ())

(defmethod perform :around ((op compile-op) (c unsafe-file))
  (setf (operation-on-warnings op) :ignore
        (operation-on-failure op) :warn) ; adjust to taste
  (call-next-method))

(defsystem #:swank
    :name "Swank is the Common Lisp back-end to Slime"
    :licence "GPL-2"
    :components
    #+cmu ((:file "swank-loader-init")
           (:file "swank-backend")
           (:file "nregex")
           (:file "swank-source-path-parser")
           (:file "swank-cmucl")
           (:file "swank"))
    #+sbcl ((:file "swank-loader-init")
            (:file "swank-backend")
            (:file "nregex")
            (:file "swank-sbcl")
	    (:file "swank-source-path-parser")
	    (:file "swank-gray")
	    (:unsafe-file "swank"))
    #+clisp ((:file "swank-loader-init")
             (:file "swank-backend")
             (:file "nregex")
             (:file "xref")
             (:file "metering")
	     (:file "swank-clisp")
             (:file "swank-gray")
	     (:file "swank"))
    :depends-on (#+sbcl :sb-bsd-sockets))

;; swank.asd ends here
