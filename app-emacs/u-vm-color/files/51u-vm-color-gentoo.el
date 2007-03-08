
;;; u-vm-color site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(require 'u-vm-color)
(add-hook 'vm-summary-mode-hook 'u-vm-color-summary-mode)
(add-hook 'vm-select-message-hook 'u-vm-color-fontify-buffer)

