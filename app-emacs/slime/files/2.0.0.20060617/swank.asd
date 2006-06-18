;;; -*- mode: lisp; syntax: common-lisp; package: common-lisp -*-

(defpackage #:swank-system
  (:use #:common-lisp
        #:asdf))

(defpackage #:swank-loader
  (:use #:common-lisp)
  (:export #:*source-directory*
	   #:load-swank))

(in-package #:swank-system)

;; http://www.caddr.com/macho/archives/sbcl-devel/2004-3/3014.html

(defclass unsafe-file (cl-source-file) ())

(defmethod perform :around ((op compile-op) (c unsafe-file))
  (setf (operation-on-warnings op) :ignore
        (operation-on-failure op) :warn) ; adjust to taste
  (call-next-method))

(defmacro define-swank-system (&rest sysdep-components)
  `(defsystem swank
       :name "Swank is the Common Lips back-end to SLIME"
       :serial t
       :components ((:file "swank-backend")
                    (:file "nregex")
                    ,@(mapcar #'(lambda (component)
                                  (if (atom component)
                                      (list :file component)
                                      component))
                              sysdep-components)
                    (:file "swank"))
       :depends-on (#+sbcl sb-bsd-sockets)))

#+sbcl (define-swank-system
	  "swank-sbcl"
	  "swank-source-path-parser"
	  "swank-source-file-cache" 
	  "swank-gray")

#+openmcl (define-swank-system
	    "metering"
	    "swank-openmcl"
	    "swank-gray")

#+cmu (define-swank-system
	"swank-source-path-parser" 
	"swank-source-file-cache"
	"swank-cmucl")

#+clisp (define-swank-system
	  "xref"
	  "metering"
	  "swank-clisp"
	  "swank-gray")

#+armedbear (define-swank-system
		"swank-abcl")

#+ecl (define-swank-system
	  "swank-ecl" "swank-gray")

(in-package #:swank-loader)

(defvar *source-directory* 
  (make-pathname :name nil :type nil 
                 :defaults (or *load-pathname* *default-pathname-defaults*))
  "The directory where to look for the source.")


(defun load-user-init-file ()
  "Load the user init file, return NIL if it does not exist."
  (load (merge-pathnames (user-homedir-pathname)
                         (make-pathname :name ".swank" :type "lisp"))
        :if-does-not-exist nil))

(defun load-site-init-file (directory)
  (load (make-pathname :name "site-init" :type "lisp"
                       :defaults directory)
        :if-does-not-exist nil))

(defun load-swank (&key (source-directory *source-directory*))
  (asdf:oos 'asdf:load-op :swank)
  (funcall (intern (string :warn-unimplemented-interfaces) :swank-backend))
  (load-site-init-file source-directory)
  (load-user-init-file))

(load-swank)

;; swank.asd ends here
