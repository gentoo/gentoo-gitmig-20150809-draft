
;;; speedbar site-lisp configuration

(setq load-path (cons (concat "@SITELISP@") load-path))
;;; necessary for FSF GNU Emacs only
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
;; Texinfo fancy chapter tags
(add-hook 'texinfo-mode-hook (lambda () (require 'sb-texinfo)))
;; HTML fancy chapter tags
(add-hook 'html-mode-hook (lambda () (require 'sb-html)))
;; For any verison of emacs on a linux RPM based system:
(autoload 'rpm "sb-rpm" "Rpm package listing in speedbar.")
