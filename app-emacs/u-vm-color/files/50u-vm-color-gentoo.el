
;;; u-vm-color site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(require 'u-vm-color)
(add-hook 'vm-mode-hook 'u-vm-color-presentation-mode)
(add-hook 'vm-presentation-mode-hook 'u-vm-color-presentation-mode)
(add-hook 'vm-summary-mode-hook 'u-vm-color-summary-mode)

