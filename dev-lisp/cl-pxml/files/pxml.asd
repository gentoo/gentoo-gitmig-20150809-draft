
(in-package "CL-USER")

(asdf:defsystem pxml
    :depends-on (acl-compat)
    :components ((:file "pxml0")
		 (:file "pxml1")
		 (:file "pxml2")
		 (:file "pxml3")))