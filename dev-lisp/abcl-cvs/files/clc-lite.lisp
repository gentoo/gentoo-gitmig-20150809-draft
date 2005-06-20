;;;; -*- mode: common-lisp; indent-tabs-mode: nil; package: common-lisp-controller -*-

(defpackage #:common-lisp-controller
  (:use #:common-lisp))

(in-package #:common-lisp-controller)

(defvar *source-root* #p"/usr/share/common-lisp/source/")

(defvar *fasl-root* nil)

(defvar *implementation-name* "abcl")

(eval-when (:load-toplevel :compile-toplevel :execute)
  (unless (member :asdf *features*)
    (require 'asdf)))

;; I cut this out of the original Common Lisp Controller v4 from Debian

(defun calculate-fasl-root  ()
  "Inits common-lisp controller for this user"
  (unless *fasl-root*
    (setf *fasl-root*
	  ;; set it to the username of the user:
	  (let* (#-cmu
		 (homedir (pathname-directory
			   (user-homedir-pathname)))
		 ;; cmucl has searchlist home (!)
		 #+cmu
		 (homedirs (extensions:search-list "home:"))
		 #+cmu
		 (homedir (when homedirs
			    (pathname-directory
			     (first homedirs)))))
	    ;; strip off :re or :abs
	    (when (or (eq (first homedir)
			  :relative)
		      (eq (first homedir)
			  :absolute))
	      (setf homedir (rest homedir)))
	    ;; if it starts with home, nuke it
	    (when (string= (first homedir)
			   "home")
	      (setf homedir (rest homedir)))
	    ;; now append *implementation-name*
	    (setf homedir (append homedir
				  (list *implementation-name*)))
	    ;; this should be able to cope with
	    ;; homedirs like /home/p/pv/pvaneynd ...
	    (merge-pathnames
	     (make-pathname
	      :directory `(:relative ,@homedir))
	     #p"/var/cache/common-lisp-controller/")))))

(defun source-root-path-to-fasl-path (source)
  "Converts a path in the source root into the equivalent path in the fasl root"
  (calculate-fasl-root)
  (merge-pathnames 
   (enough-namestring source (asdf::resolve-symlinks *source-root*))
   *fasl-root*))

(defmethod asdf:output-files :around ((op asdf:operation) (c asdf:component))
  (let ((orig (call-next-method)))
    (mapcar #'source-root-path-to-fasl-path orig)))

(pushnew #p"/usr/share/common-lisp/systems/" asdf:*central-registry*)
