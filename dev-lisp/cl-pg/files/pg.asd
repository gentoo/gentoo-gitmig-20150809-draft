;;; -*- Mode: lisp -*-

(in-package :asdf)

(defclass pg-component (cl-source-file)
  ())

(defmethod perform :before ((o load-op) (c pg-component))
  (ext:load-foreign "/usr/lib/libcrypt.a"))

;; only tested with cmu
#+:cmu
(defsystem :pg
    :components ((:pg-component "pg")))


