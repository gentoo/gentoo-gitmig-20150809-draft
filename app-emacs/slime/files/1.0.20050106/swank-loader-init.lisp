;; -*- lisp -*-

;; This file is NOT part of SLIME.

;; This file is provided by the Gentoo port to implement the
;; user-init-file loader.
;; 
;; Matthew Kennedy <mkennedy@gentoo.org>

(defpackage #:swank-loader
  (:use #:common-lisp))

(in-package #:swank-loader)

(defun user-init-file ()
  "Return the name of the user init file or nil."
  (probe-file (merge-pathnames (user-homedir-pathname)
                               (make-pathname :name ".swank" :type "lisp"))))

(when (user-init-file)
  (load (user-init-file)))
