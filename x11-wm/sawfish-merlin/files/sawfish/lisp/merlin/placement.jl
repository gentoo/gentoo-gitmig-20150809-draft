;; merlin/placement.jl -- opaque placement and with resize

;; version 0.4

;; Copyright (C) 2000-2001 merlin <merlin@merlin.org>

;; http://merlin.org/sawfish/

;; this is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; this is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with sawfish; see the file COPYING.  If not, write to
;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;;;;;;;;;;;;;;;;;
;; INSTALLATION ;;
;;;;;;;;;;;;;;;;;;

;; Create a directory ~/.sawfish/lisp/merlin and then put this file there:
;;   mkdir -p ~/.sawfish/lisp/merlin
;;   mv placement.jl ~/.sawfish/lisp/merlin

;; Then add to your .sawfishrc:
;;   (require 'merlin.placement)

;; Then restart sawfish and go to Customize->Placement and select
;; (opaque-)interactively(-with-resize)
;;     - Henceforth, windows will be placed opaquely if you so choose.
;;     - If you select -with-resize then if you place
;;       a window with a mouse button and hold it down,
;;       you can drag-resize the window (twm-style).

; BUGS: Sometimes windows get messed up by this. I don't know
; when or why so I don't know what to do about it.

; TODO: do I fire the after-place / before-resize hooks on go-resize
; TODO: do i set the cursor - resize-cursor-shape on go-resize

(define-structure merlin.placement

  (export)

  (open
   rep
   rep.system
   sawfish.wm.placement
   sawfish.wm.commands
   sawfish.wm.commands.move-resize
   sawfish.wm.events
   sawfish.wm.misc
   sawfish.wm.windows)

  (define (merlin-placement-go-resize) ;; hackalicious
    (setq move-resize-function 'resize)
    (setq move-resize-old-x move-resize-x)
    (setq move-resize-old-y move-resize-y))

  (define (merlin-place-window w opaque resize)
    (accept-x-input)
    (when (window-id w)
      (let
	  ((move-outline-mode (if opaque 'opaque 'box))
	   (resize-edge-mode 'border-grab)
	   (ptr (query-pointer))
	   (siz (window-dimensions w))
	   (dims (window-frame-dimensions w)))
	(move-window-to w (- (car ptr) (quotient (car dims) 2))
			(- (cdr ptr) (quotient (cdr dims) 2)))
	(when opaque
	  (hide-window w) (show-window w)) ;; hackalicious
	(when resize
	  (bind-keys move-resize-map "Any-Click1" 'merlin-placement-go-resize))
	(move-window-interactively w)
	(when resize
	  (unbind-keys move-resize-map "Any-Click1")))))

  (define (place-window-opaque-interactively w)
    (merlin-place-window w t nil))

  (define (place-window-opaque-interactively-with-resize w)
    (merlin-place-window w t t))

  (define (place-window-interactively-with-resize w)
    (merlin-place-window w nil t))

  (define-placement-mode 'opaque-interactively
    place-window-opaque-interactively)

  (define-placement-mode 'opaque-interactively-with-resize
    place-window-opaque-interactively-with-resize)

  (define-placement-mode 'interactively-with-resize
    place-window-interactively-with-resize)

  (define-command 'merlin-placement-go-resize
    merlin-placement-go-resize))
