
;;; chess site-lisp configuration 

(setq load-path (cons "@SITELISP@" load-path))
(require 'chess)

;; Change the engine preference order -- gnuchess is a dependency (we
;; depend on app-games/gnuchess explicitly). We make crafty and
;; phalanx optional. The user can override this anytime using M-x
;; customize-group RET chess RET

(custom-set-variables
 '(chess-default-engine (quote (chess-gnuchess chess-crafty chess-phalanx))))
