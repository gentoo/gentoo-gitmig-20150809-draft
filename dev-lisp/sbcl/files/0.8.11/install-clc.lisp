;;; -*- Mode: LISP; Package: CL-USER -*-
;;;
;;; Copyright (C) Peter Van Eynde 2001 and Kevin Rosenberg 2002-2003
;;;
;;; License: LGPL v2
;;;
;;; Some modifications for Gentoo, Matthew Kennedy <mkennedy@gentoo.org>
;;;

(in-package "COMMON-LISP-USER")

(unless (ignore-errors
	 (load "/usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp"))
  (sb-unix:unix-exit 1))

(unless (ignore-errors
	 (common-lisp-controller:init-common-lisp-controller
	  "/usr/lib/common-lisp/sbcl/"
	  :version 3)
	 t)
  (format t "~%Error during init of common-lisp-controller~%")
  (sb-unix:unix-exit 1))

(in-package :common-lisp-controller)

(defun send-clc-command (command package)
  (let ((process
	 (sb-ext:run-program "/usr/bin/clc-send-command"
			     (list
			      (ecase command
				     (:recompile "recompile")
				     (:remove "remove"))
			      (format nil "~A" package)
			      "sbcl"
			      "--quiet")
			     :wait t)))
    (if (= (sb-ext:process-exit-code process) 0)
	(values)
        (error "An error happened during ~A of ~A for ~A~%Please see /usr/share/doc/common-lisp-controller/REPORTING-BUGS.gz"
	       (ecase command
		      (:recompile "recompilation")
		      (:remove "removal"))
	       package
	       "sbcl"))))

(in-package :common-lisp-user)

(ignore-errors
 (format t "~%Saving to sbcl-new.core...")
 (sb-ext:gc :full t)
;(setf ext:*batch-mode* nil)
 (sb-ext:save-lisp-and-die "sbcl-new.core"
			   :purify t))
