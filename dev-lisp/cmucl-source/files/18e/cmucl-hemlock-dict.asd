;;; -*- Mode: lisp -*-

;;; This is just a sample of building series with MK defsystem. You
;;; may need to change :source-pathname appropriately for your system.

(in-package :asdf)

#+cmu
(eval-when (:load-toplevel :compile-toplevel :execute)
  (defun user::hemlock-compile-dictionary (source-file
                                           &rest rest
                                           &key
                                           output-file
                                           error-file
                                           errors-to-terminal
                                           &allow-other-keys )
    (funcall
     (fdefinition (intern "BUILD-DICTIONARY"
                          "SPELL"))
     source-file
     output-file)))

#+cmu
(defclass dictionary-source-file (source-file) ())

#+cmu
(defmethod source-file-type ((c dictionary-source-file) (s module))
  "text")

#+cmu
(defmethod output-files ((op compile-op) (c dictionary-source-file))
    (let* ((path (component-pathname c))
	   (list (make-pathname :defaults path
				:type "bin")))
	(list list)))
#+cmu
(defmethod perform ((op compile-op) (c dictionary-source-file))
  (user::hemlock-compile-dictionary (component-pathname c)
				   :output-file (car (output-files op c))))

(defmethod perform ((op load-op) (c dictionary-source-file))
  )

#+nil
#+common-lisp-controller
(defmethod perform ((op load-compiled-op) (c dictionary-source-file))
)


#+cmu
(defsystem :cmucl-hemlock-dict
    :depends-on (:cmucl-hemlock-base)
    :components
    ((:dictionary-source-file "spell-dictionary")))

