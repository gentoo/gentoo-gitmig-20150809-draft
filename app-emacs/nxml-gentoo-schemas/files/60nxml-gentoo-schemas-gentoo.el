
;;; nxml-gentoo-schemas site-lisp configuration

;; This must come after the nxml-mode site initialisation,
;; because rng-schema-locating-files-default is set there.
;; "eval-after-load" so that it works with builtin nxml-mode in Emacs 23.
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files-default
		"@SITEETC@/schemas.xml"))
