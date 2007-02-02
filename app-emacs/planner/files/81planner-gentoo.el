
;;; planner site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(require 'planner-autoloads)
(require 'planner-w3m)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/muse")
     (add-to-list 'load-path "/usr/share/emacs/site-lisp/planner")
     (add-to-list 'load-path "/usr/share/emacs/site-lisp/remember")
(require 'planner)
 (require 'remember-planner)
 (setq remember-handler-functions '(remember-planner-append))
 (setq remember-annotation-functions planner-annotation-functions)