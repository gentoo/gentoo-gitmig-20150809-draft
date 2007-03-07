
;;; cdrw site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'cdrw "cdrw" "CDRW Creation" t)
(autoload 'cdrw-from-file "cdrw" "Load previously saved mark-file." t)

;; This binds the commands that open CDRW buffers to "C-c @ l" and
;; "C-c @ f" respectively. (the '@' character kinda looks like a CD
;; :).

(global-set-key "\C-c@" nil)
(global-set-key "\C-c@l" 'cdrw)
(global-set-key "\C-c@f" 'cdrw-from-file)
