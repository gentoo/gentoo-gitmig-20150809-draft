
;;; mldonkey site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(require 'mldonkey)

(setq mldonkey-host "localhost")
(setq mldonkey-port 4000) ; use the port of the telnet interface here

(setq mldonkey-console-use-color t)

;; (setq mldonkey-user "admin")
;; (setq mldonkey-passwd "admin")
;; (add-hook 'mldonkey-motd-hook 'mldonkey-auth)
;; (add-hook 'mldonkey-console-hook 'mldonkey-console-auth)

(setq mldonkey-show-network nil)
(setq mldonkey-show-number t)
(setq mldonkey-show-filename t)
(setq mldonkey-show-percent t)
(setq mldonkey-show-downloaded nil)
(setq mldonkey-show-size nil)
(setq mldonkey-show-left nil)
(setq mldonkey-show-days t)
(setq mldonkey-show-last-seen t)
(setq mldonkey-show-active-sources nil)
(setq mldonkey-show-total-sources nil)
(setq mldonkey-show-rate t)
(setq mldonkey-show-priority nil)
(setq mldonkey-show-finished-network nil)
(setq mldonkey-show-finished-number t)
(setq mldonkey-show-finished-filename t)
(setq mldonkey-show-finished-size t)
(setq mldonkey-show-finished-md4 nil)

(add-to-list 'mldonkey-vd-filename-filters 'mldonkey-vd-filename-remove-p20)

(setq mldonkey-vd-sort-functions
      '((not mldonkey-vd-sort-dl-state)
        (not mldonkey-vd-sort-dl-percent)))

(setq mldonkey-vd-sort-fin-functions
      '(mldonkey-vd-sort-dl-number))

(add-hook 'mldonkey-pause-hook 'mldonkey-vd)
(add-hook 'mldonkey-resume-hook 'mldonkey-vd)
(add-hook 'mldonkey-commit-hook 'mldonkey-vd)
(add-hook 'mldonkey-recover-temp-hook 'mldonkey-vd)
