;; merlin/message.jl -- fancier message display

;; version 0.5

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

;; TODO: click to hide?

;; NB: icon handling willnot remain the ugly same!!

(define-structure merlin.message

  (export
   fancy-message
   hide-fancy-message)

  (open
   rep
   sawfish.wm.misc
   sawfish.wm.colors
   sawfish.wm.fonts
   sawfish.wm.images
   sawfish.wm.windows.subrs
   sawfish.wm.util.x
   merlin.util)

  (define message-window nil)
  (define message-gc nil)
  (define message-msg nil)
  (define message-attrs nil)
  (define message-pos (cons 0 0))
  (define message-dims (cons 0 0))

  (define default-message-padding (cons 4 4))
  (define default-message-foreground "black")
  (define default-message-background "white")
  (define default-message-border-color "black")
  (define default-message-border-width 1)
  (define default-message-spacing 1)
  (define default-message-position (cons-quotient (screen-dimensions) 2))

  (define (repaint-message-window id)
    (when (eq id message-window)
      (let
	  ((pad (cdr (assqd 'padding message-attrs default-message-padding)))
	   (fg (colorify (cdr (assqd 'foreground message-attrs default-message-foreground))))
	   (font (fontify (cdr (assq 'font message-attrs))))
	   (justify (cdr (assqd 'x-justify message-attrs 'left)))
	   (spacing (cdr (assqd 'spacing message-attrs default-message-spacing)))
	   (w (car message-dims)) x y)
       (setq y (cdr pad))
       (x-clear-window message-window)
       (x-change-gc message-gc `((foreground . ,fg)))
       (mapcar (lambda (msg)
	   (when (stringp msg)
	     (cond ((eq 'left justify)
		    (setq x (car pad)))
		   ((eq 'center justify)
		    (setq x (quotient (- w (text-width msg font)) 2)))
		   (t ;; (eq 'right justify)
		    (setq x (- w (text-width msg font) (car pad)))))
	     (setq y (+ y (font-ascent font) spacing)) ;; spacing not on first line!
	     (x-draw-string message-window message-gc (cons x y) msg font)
	     (setq y (+ y (font-descent font))))
           (when (imagep msg)
             (setq y (+ y spacing)) ;; spacing not on first line!
             (x-draw-image msg message-window (cons (quotient (- w (car (image-dimensions msg))) 2) y))
             (setq y (+ y (cdr (image-dimensions msg)))))
	   (when (consp msg)
	     (cond ((eq 'font (car msg))
		    (setq font (fontify (cdr msg))))
		   ((eq 'foreground (car msg))
		    (x-change-gc message-gc `((foreground . ,(colorify (cdr msg))))))
		   ((eq 'x-justify (car msg))
		    (setq justify (cdr msg)))
		   ((eq 'spacing (car msg))
		    (setq spacing (cdr msg))))))
	    message-msg))))

  (define (calculate-message-window-dimensions)
    (let
	((pad (cdr (assqd 'padding message-attrs default-message-padding)))
	 (font (fontify (cdr (assq 'font message-attrs))))
	 (spacing (cdr (assqd 'spacing message-attrs default-message-spacing))))
       (setq message-dims (cons (* 2 (car pad)) (* 2 (cdr pad))))
       (mapcar (lambda (msg)
	   (when (stringp msg)
	     (rplaca message-dims
		  (max (car message-dims) (+ (* 2 (car pad)) (text-width msg font))))
	     (rplacd message-dims
		  (+ (cdr message-dims) spacing (font-height font)))) ;; spacing not on first line!
           (when (imagep msg)
	     (rplacd message-dims
		  (+ (cdr message-dims) spacing (cdr (image-dimensions msg))))) ;; spacing not on first line!
	   (when (consp msg)
	     (cond ((eq 'font (car msg))
		    (setq font (fontify (cdr msg))))
		   ((eq 'spacing (car msg))
		    (setq spacing (cdr msg))))))
	    message-msg)))

  (define (calculate-message-window-position)
    (let*
	((pos (cdr (assqd 'position message-attrs default-message-position)))
	 (bw (cdr (assqd 'border-width message-attrs default-message-border-width)))
	 (dim (cons+ message-dims bw bw))
	 (gravity (cdr (assqd 'gravity message-attrs 'center))))
      (setq message-pos (cons-max (cons-min (gravitate pos dim gravity) (cons- (screen-dimensions) dim)) 0))))

  (define (message-window-event-handler type #!optional args)
    (cond ((eq type 'expose) (repaint-message-window message-window))))

  (define (create-message-window)
    (let*
	((bw (cdr (assqd 'border-width message-attrs default-message-border-width)))
	 (bg (colorify (cdr (assqd 'background message-attrs default-message-background))))
	 (bd (colorify (cdr (assqd 'border-color message-attrs default-message-border-color))))
	 (window-attrs `((background . ,bg)
			 (border-color . ,bd)
			 (override-redirect . ,t)
			 (save-under . ,nil)
			 (event-mask . ,'(exposure))))
	 (gc-attrs `((background . ,bg))))

      (setq message-window (x-create-window message-pos message-dims bw window-attrs message-window-event-handler))
      (setq message-gc (x-create-gc message-window gc-attrs))
      (x-map-window message-window t)))

  (define (update-message-window)
    (let*
	((x (car message-pos))
	 (y (cdr message-pos))
	 (w (car message-dims))
	 (h (cdr message-dims))
	 (bw (cdr (assqd 'border-width message-attrs default-message-border-width)))
	 (bg (colorify (cdr (assqd 'background message-attrs default-message-background))))
	 (bd (colorify (cdr (assqd 'border-color message-attrs default-message-border-color))))
	 (window-config `((x . ,x) (y  . ,y)
			  (width . ,w) (height . ,h)
			  (border-width . ,bw)
			  (stack-mode . top-if)))
	 (window-attrs `((background . ,bg)6
			 (border-color . ,bd)))
	 (gc-attrs `((background . ,bg))))

      (x-configure-window message-window window-config)
      (x-change-window-attributes message-window window-attrs)
      (x-change-gc message-gc gc-attrs)))

  ;; supported global attributes:
  ;;
  ;; 'position - (x . y) position
  ;; 'gravity - how the window is positioned relative to position
  ;; 'font - default font
  ;; 'foreground - default foreground
  ;; 'background - default background
  ;; 'border-color - border color
  ;; 'font - default font
  ;; 'x-justify - default justification
  ;; 'spacing - interline spacing
  ;; 'padding - (x . y) outer padding
  ;; 'border-width - border width

  ;; supported inline attributes:
  ;;
  ;; 'font - font
  ;; 'foreground - foreground
  ;; 'x-justify - justification
  ;; 'spacing - interline spacing

  (define (fancy-message message attrs)
    (setq message-msg message)
    (setq message-attrs attrs)
    (calculate-message-window-dimensions)
    (calculate-message-window-position)
    (if message-window
      (update-message-window)
      (create-message-window))
    (repaint-message-window message-window))

  (define (hide-fancy-message)
    (when message-window
      (x-destroy-window message-window)
      (setq message-window nil))
    (when message-gc
      (x-destroy-gc message-gc)
      (setq message-gc nil))))
