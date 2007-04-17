
;;; semantic site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'semantic-map-buffers "semantic-util")

;; To determine what should be done here every semantic release, check
;; semantic-load.el.  Here we replicate the (when ... sexp twoards the
;; end of the source.

;; We turn on everything except foor `global-semantic-stickyfunc-mode'
;; as it seems to be a source of consternation for new and experienced
;; users alike.

(setq semantic-load-turn-everything-on nil
      semantic-load-turn-useful-things-on nil)
(require 'semantic-load)

(global-semantic-show-dirty-mode 1)
(global-senator-minor-mode 1)
(global-semantic-show-unmatched-syntax-mode 1)
(global-semantic-auto-parse-mode 1)
(global-semanticdb-minor-mode 1)
(global-semantic-summary-mode 1)
;; (global-semantic-stickyfunc-mode 1)

(when (and (eq window-system 'x)
	   (locate-library "imenu"))
  (add-hook 'semantic-init-hooks (lambda ()
				   (imenu-add-to-menubar "TOKENS"))))
