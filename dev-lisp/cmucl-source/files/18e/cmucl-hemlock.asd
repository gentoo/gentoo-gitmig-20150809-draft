;;; -*- Mode: lisp -*-

;;; This is just a sample of building series with MK defsystem. You
;;; may need to change :source-pathname appropriately for your system.

(in-package :asdf)

#+cmu
(defclass dummy-component (component)
  ())

#+cmu
(defmethod perform ((o load-op) (c dummy-component))
    (format t "~&Ignorings...")(force-output)
    (values))

#+cmu
(defmethod perform ((o compile-op) (c dummy-component))
    (format t "~&Ignorings.2..")(force-output)
    (values))

#+cmu
(defmethod traverse ((o load-op) (c dummy-component))
    (format t "~&Bignoings...")(force-output)
    (values))

#+cmu
(defmethod traverse ((o compile-op) (c dummy-component))
    (format t "~&Bignoings.2..")(force-output)
    (values))


#+cmu
(defsystem :cmucl-hemlock
    :depends-on (:cmucl-hemlock-base
		 :cmucl-hemlock-dict)
    :components ((:dummy-component "dummy")))
    
;; not handled:
;;(unless (probe-file "spell-dictionary.bin")
;;   (load "spell-rt")
;;   (load "spell-corr")
;;   (load "spell-aug")
;;   (load "spell-build")
;;   (funcall (fdefinition (intern "BUILD-DICTIONARY" "SPELL"))
;;            "spell-dictionary.text"
;;            "spell-dictionary.bin"))

