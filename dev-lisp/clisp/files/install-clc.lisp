;;;; -*- Mode: Lisp; Package: CL-USER -*-
;;;; Copyright (c) 2002 Kevin M. Rosenberg
;;;; GNU GPL v2 license

(in-package :cl-user)

(load "/usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp")

(in-package :common-lisp-controller)

(init-common-lisp-controller "/usr/lib/common-lisp/clisp/" :version 3)

(defun send-clc-command (command package)
  "Overrides global definition"
  (ext:shell (c-l-c:make-clc-send-command-string command package "clisp")))
