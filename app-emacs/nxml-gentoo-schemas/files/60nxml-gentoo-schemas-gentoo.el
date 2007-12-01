
;;; nxml-gentoo-schemas site-lisp configuration

;; This must come after the nxml-mode site initialisation,
;; because rng-schema-locating-files-default is set there.
(add-to-list 'rng-schema-locating-files-default
	     "@SITEETC@/schemas.xml")
