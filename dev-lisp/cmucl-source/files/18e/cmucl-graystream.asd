;;; -*- Mode: lisp -*-
;;
;; Graystream system definition
(in-package :asdf)

#+cmu
(defsystem cmucl-graystream
    :components
  ((:file "gray-streams-class")
   (:file "gray-streams"
          :depends-on ("gray-streams-class"))))



