
;;; chess site-lisp configuration 

(add-to-list 'load-path "@SITELISP@")

(autoload 'chess "chess"
  "Start a game of chess, playing against ENGINE (a module name)." t)
(autoload 'chess-link "chess-link"
  "Play out a game between two engines, and watch the progress." t)
(autoload 'chess-pgn-read "chess-pgn"
  "Read and display a PGN game after point." t)
(autoload 'chess-pgn-mode "chess-pgn"
  "A mode for editing chess PGN files." t)
(defalias 'pgn-mode 'chess-pgn-mode)
(autoload 'chess-puzzle "chess-puzzle"
  "Pick a random puzzle from FILE, and solve it against the default engine." t)
(autoload 'chess-tutorial "chess-tutorial"
  "A simple chess training display." t)
(autoload 'chess-ics "chess-ics"
  "Connect to an Internet Chess Server." t)

(add-to-list 'auto-mode-alist '("\\.pgn\\'" . chess-pgn-mode))

(custom-set-variables
 '(chess-images-directory "/usr/share/pixmaps/chess/xboard")
 '(chess-sound-directory "/usr/share/sounds/chess"))

;; Change the engine preference order -- gnuchess is a dependency
;; (we depend on app-games/gnuchess explicitly). We make crafty and
;; phalanx optional. The user can override this anytime using M-x
;; customize-group RET chess RET

(custom-set-variables
 '(chess-default-engine (quote (chess-gnuchess chess-crafty chess-phalanx))))
