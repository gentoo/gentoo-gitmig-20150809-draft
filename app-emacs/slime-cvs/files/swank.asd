;;; -*- mode: lisp; syntax: common-lisp; base: 10; package: common-lisp-user -*-

(in-package #:common-lisp-user)

(defpackage #:swank                                                                           
  (:use #:asdf                                                                                
        #:common-lisp)                                                                        
  (:export #:start-server #:create-swank-server                                               
           #:*sldb-pprint-frames*))

(in-package #:swank)

(defsystem #:swank
  :name "Swank is the Common Lisp back-end to Slime"
  :author "Matthew Kennedy <mkennedy@gentoo.org>"
  :maintainer "Matthew Kennedy <mkennedy@gentoo.org>"
  :licence "GPL-2"
  :components ((:file "swank")
	       (:file "swank-backend" :depends-on ("swank"))
	       (:file "null-swank-impl" :depends-on ("swank-backend"))
;; 	       (:file "swank-backend" :depends-on ("null-swank-impl"))
;; 	       (:file "null-swank-impl" :depends-on ("swank"))
	       #+cmu (:file "swank-cmucl" :depends-on ("null-swank-impl"))
	       #+sbcl (:file "swank-sbcl" :depends-on ("null-swank-impl"))))
