;;; -*- Mode: Lisp; Package: System -*-
;;;
;;; **********************************************************************
;;; This code was written as part of the CMU Common Lisp project at
;;; Carnegie Mellon University, and has been placed in the public domain.
;;;

;;; Heavy modifications by Peter Van Eynde

(in-package "SYSTEM")

(if (probe-file "/etc/lisp-config.lisp")
    (load "/etc/lisp-config.lisp")
  (format t "~%;;; Hey: there is no /etc/lisp-config.lisp file, please run \"dpkg-reconfigure common-lisp-controller\" as root"))

;;; If you have sources installed on your system, un-comment the following form
;;; and change it to point to the source location.  This will allow the Hemlock
;;; "Edit Definition" command and the debugger to find sources for functions in
;;; the core.
(setf (ext:search-list "target:")
      '(
        "/usr/share/common-lisp/source/cmucl/"      ; object dir
        ))

(setf (ext:search-list "library:") '("/usr/lib/cmucl/" "/usr/lib/cmucl/lib/"))
;;; for safety...

;;; optional extentions to the lisp image: delete if you
;;; don't like them :-).
(in-package :common-lisp-user)

;;; newbie functions, delete if you don't like them

#-hemlock
(defun ed (&rest rest)
  (multiple-value-bind (return errorp)
    (ignore-errors (require :cmucl-hemlock))
   (if errorp
     (error "Sorry, cannot find hemlock, please install and use ilisp. Reason: ~S" errorp)
    (apply #'ed rest))))

(defun help ()
  (format t "~
Welcome to CMUCL for Linux.

If you aren't running this with ilisp in emacs,
or aren't intending to use hemlock then you
deserve to lose. :-)

Read the documentation in /usr/share/doc/cmucl.

(quit) is to quit.
(ed) starts hemlock (if installed)
(demo) shows a list of demos
(describe 'progn) gives information about progn for 
 example.
(inspect '*a*) interactively inspects *a* for example.
"))

(defun demo ()
  (format t "Some demos are in the source package, some in the
normal package.

General demos:
CLX demos:
 if you have installed cmucl-source you can do:
 (require :cmucl-clx)
 (load \"cl-library:cmucl-clx;demo;hello\")
 (xlib::hello-world \"\")
 (load \"cl-library:;cmucl-clx;demo;menu\")
 (xlib::just-say-lisp \"\")
 (xlib::pop-up \"\"
	       '(\"Linux\" \"FreeBSD\" \"OpenBSD\"))
  exit by pressing control+C followed by a keypress.

Clue demos:
 if you have installed the clue package you can do:
 (require :clue)
 (load \"cl-library:;clue;examples;menu\")
 (clue-examples::beatlemenuia \"\")
 (clue-examples::pick-one \"\"
			  \"One\"
			  \"Two\"
			  \"Three\")
 (clue-examples::just-say-lisp \"\")
 
 or you can use the Clio demos:
 (require :clio)
 (require :clio-examples)
 (clio-examples::sketch :host  "")

Pictures demos:
 (require :pictures)
 (load \"cl-library:;pictures;examples;road-demo\")
 (pictures::road-demo)
 press control-a to animate

"))


