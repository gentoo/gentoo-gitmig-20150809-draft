;;; -*- Mode: Lisp; Package: System -*-
;;;
;;; **********************************************************************

;;; This code was written as part of the CMU Common Lisp project at
;;; Carnegie Mellon University, and has been placed in the public domain.

;;; Heavy modifications by Peter Van Eynde (The Debian Project)

;;; This code was imported from The Debian Project and modified by
;;; Matthew Kennedy <mkennedy@gentoo.org>.

(in-package "SYSTEM")

(if (probe-file "/etc/lisp-config.lisp")
    (load "/etc/lisp-config.lisp")
  (format t "~%;;; Warning: there is no /etc/lisp-config.lisp file"))

(setf (ext:search-list "target:")
      '("/usr/share/common-lisp/source/"))
;; (setf (ext:search-list "library:")
;;       '("/opt/cmucl/lib/cmucl/lib/" "/opt/cmucl/src/"))

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
Welcome to CMUCL for GNU/Linux.

If you aren't running this with ilisp in emacs, or aren't intending to
use hemlock then you deserve to lose. :-)

Read the documentation in /usr/share/doc/cmucl-bin*/.

(quit)             quit
(ed)               starts hemlock
(demo)             shows a list of demos
(describe 'progn)  gives information about progn for example
(inspect '*a*)     interactively inspects *a* for example
"))

(defun demo ()
  (format t "~
Some demos are in the source package, some in the normal package.

General demos

CLX demos

 (require :clx)
 (load \"library:clx/demo/hello\")
 (xlib::hello-world \"\")

 (load \"library:clx/demo/menu\")
 (xlib::just-say-lisp \"\")
 (xlib::pop-up \"\" '(\"Linux\" \"FreeBSD\" \"OpenBSD\"))

 exit by pressing control+C followed by a keypress.

"))


