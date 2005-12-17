
;;; uim-el site-lisp configuration

(require 'uim)

;; assign C-o to uim-mode-switch
(global-set-key "\C-o" 'uim-mode-switch)
(define-key uim-mode-map "\C-o" 'uim-mode-switch)

;; please set this to nil if you prefer candidate display in minibuffer
(setq uim-candidate-display-inline-default t)
