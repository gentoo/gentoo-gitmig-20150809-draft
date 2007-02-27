
;;; chess site-lisp configuration 

(add-to-list 'load-path "@SITELISP@")
(autoload 'chess "chess" "Play a game of chess" t)

(custom-set-variables
 '(chess-images-directory "/usr/share/pixmaps/chess/xboard")
 '(chess-sound-directory "/usr/share/sounds/chess"))

;; Change the engine preference order -- gnuchess is a dependency (we
;; depend on app-games/gnuchess explicitly). We make crafty and
;; phalanx optional. The user can override this anytime using M-x
;; customize-group RET chess RET

(custom-set-variables
 '(chess-default-engine (quote (chess-gnuchess chess-crafty chess-phalanx))))
