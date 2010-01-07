;; site-init for sci-mathematics/fricas
(add-to-list 'load-path "/usr/share/emacs/site-lisp/fricas")
(setq auto-mode-alist (cons '("\\.fri" . fricas-mode) auto-mode-alist))
;(require 'fricas)
