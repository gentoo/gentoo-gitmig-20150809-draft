;;;; ASDF for http://common-lisp.net/project/rfc2388/ by Matthew Kennedy
;;;; <mkennedy@gentoo.org>

(in-package #:common-lisp)

(defpackage #:rfc2388-system
  (:use #:asdf
	#:common-lisp))

(in-package #:rfc2388-system)

(defsystem #:rfc2388
    :components ((:file "rfc2388")))
