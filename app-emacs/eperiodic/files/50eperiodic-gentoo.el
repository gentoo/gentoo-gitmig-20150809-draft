
;;; eperiodic site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'eperiodic "eperiodic"
  "Display the periodic table of the elements in its own buffer"
  t)
