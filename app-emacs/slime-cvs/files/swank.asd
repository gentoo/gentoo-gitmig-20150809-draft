;;; -*- mode: lisp; syntax: common-lisp; indent-tabs-mode: nil; package: cl-user -*-

(defpackage #:swank-system
  (:use #:common-lisp
        #:asdf))

(in-package #:swank-system)

(defsystem #:swank
    :name "Swank is the Common Lisp back-end to Slime"
    :licence "GPL-2"
    :components
    #+cmu ((:file "swank-backend")
           (:file "swank")
           (:file "swank-source-path-parser")
           (:file "swank-cmucl"))
    #+sbcl ((:file "swank-backend")
            (:file "swank")
	    (:file "swank-source-path-parser")
	    (:file "swank-sbcl")
	    (:file "swank-gray"))
    #+clisp ((:file "swank-backend")
             (:file "swank")
	     (:file "xref")
	     (:file "swank-clisp")
	     (:file "swank-gray"))
    #+sbcl :depends-on #+sbcl (sb-bsd-sockets))

;; swank.asd ends here
