
;;; Wanderlust site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

(setq wl-icon-directory "/usr/share/wl/icons")
