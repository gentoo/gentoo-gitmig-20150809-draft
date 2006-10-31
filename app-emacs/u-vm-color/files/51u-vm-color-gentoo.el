
;;; u-vm-color site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(require 'u-vm-color)
(add-hook 'vm-summary-mode-hook 'u-vm-color-summary-mode)
(add-hook 'vm-select-message-hook 'u-vm-color-fontify-buffer)

