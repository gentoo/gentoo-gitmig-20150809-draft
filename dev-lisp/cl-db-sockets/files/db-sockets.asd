;;; -*-  Lisp -*-

(defpackage #:db-sockets-system (:use #:asdf #:cl))
(in-package #:db-sockets-system)

;;; constants.lisp requires special treatment

(defclass shared-library-file (source-file)
  ((loaded :initform nil)))

(defmethod perform ((o load-op) (c shared-library-file))
  (unless (slot-value c 'loaded)
    (let ((filename (make-pathname
		     :name (pathname-name (component-pathname c))
		     :type "so"
		     :directory '(:absolute "usr" "lib" "db-sockets"))))
      #+(or cmu scl) (ext:load-foreign filename)
      #+sbcl (sb-alien:load-1-foreign filename))
    (setf (slot-value c 'loaded) t)))

(defmethod operation-done-p ((o load-op) (c shared-library-file))
  (slot-value c 'loaded))

(defmethod operation-done-p ((o compile-op) (c shared-library-file))
  t)

(defmethod source-file-type ((c shared-library-file) (s module))
  "so")

#+(or sbcl cmu scl)
(defsystem db-sockets
    :version "0.57.1"
    :perform (load-op :after (op db-sockets)
		      (pushnew :db-sockets cl:*features*))
    :depends-on (:rt)
    :components ((:file "defpackage")
		 (:file "split" :depends-on ("defpackage"))
                 (:file "array-data" :depends-on ("defpackage"))
		 (:shared-library-file "alien")
		 (:file "malloc" :depends-on ("defpackage"))
		 (:file "foreign-glue" :depends-on ("defpackage" "malloc"))
		 (:file "constants-arch" :depends-on ("defpackage"))
		 (:file "sockets" :depends-on ("constants-arch"))
		 #+ignore
		 (:file "sockets"
			:in-order-to ((compile-op
				       (load-op "constants-arch"))))
		 (:file "sockopt" :depends-on ("sockets"))
		 (:file "inet" :depends-on ("sockets" "split"  "constants-arch" ))
		 (:file "unix" :depends-on ("sockets" "split" "constants-arch" ))
		 (:file "name-service" :depends-on ("sockets" "constants-arch" "alien"))
		 (:file "misc" :depends-on ("sockets" "constants-arch"))
		 (:file "def-to-lisp")
		 (:file "tests" :depends-on ("inet" "sockopt"))
		 ))
