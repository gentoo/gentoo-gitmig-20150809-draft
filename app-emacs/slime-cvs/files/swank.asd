;;; -*- mode: lisp; syntax: common-lisp; indent-tabs-mode: nil; package: cl-user -*-

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
    #+cmu ((:file "swank-backend")
           (:file "nregex")
           (:file "swank-source-path-parser")
           (:file "swank-cmucl")
           (:file "swank"))
    #+sbcl ((:file "swank-backend")
            (:file "swank-sbcl")
            (:file "nregex")
	    (:file "swank-source-path-parser")
	    (:file "swank-gray")
	    (:unsafe-file "swank"))
    #+clisp ((:file "swank-backend")
             (:file "nregex")
             (:file "xref")
             (:file "metering")
	     (:file "swank-clisp")
             (:file "swank-gray")
	     (:file "swank"))
    #+sbcl :depends-on #+sbcl (:sb-bsd-sockets))

;; swank.asd ends here
