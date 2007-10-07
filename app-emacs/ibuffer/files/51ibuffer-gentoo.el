
;;; ibuffer site-lisp configuration

;; Emacs 22 and later include ibuffer
(unless (fboundp 'ibuffer)
  (add-to-list 'load-path "@SITELISP@")
  (autoload 'ibuffer "ibuffer"
    "Begin using `ibuffer' to edit a list of buffers." t)
  (autoload 'ibuffer-and-update "ibuffer"
    "Like `ibuffer', but update the list of buffers too." t)
  (autoload 'ibuffer-and-update-other-window "ibuffer"
    "Like `ibuffer-and-update', but use another window." t))
