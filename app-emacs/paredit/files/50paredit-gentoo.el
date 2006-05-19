
;;; paredit site-lisp configuration 

(add-to-list 'load-path "@SITELISP@")
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)
(let ((turn-on-paredit-mode (lambda () (paredit-mode 1))))
  ;; some hooks recommended by the paredit source code (except for
  ;; emacs-lisp-mode-hook):
  (add-hook 'lisp-mode-hook turn-on-paredit-mode)
  (add-hook 'scheme-mode-hook turn-on-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook turn-on-paredit-mode))

