;; merlin/ugliness.jl -- options for ugliness

;; version 0.9.2

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
;;   mv ugliness.jl ~/.sawfish/lisp/merlin

;; You also need merlin/util.jl, merlin/uglicon.jl and merlin/message.jl.

;; Then add to your .sawfishrc:
;;   (require 'merlin.ugliness)

;; Then restart sawfish and go to Customize->Focus or Customize->Move/Reisze.
;;     - You should have lots of options for configuring ugliness.
;; Also go to Customize->Appearance->Window icons
;;     - Here you can configure how window icons are determined
;; Also go to Customize->Matched windows->Appearance
;;     - Here you can specify per-window icons

;; TODO: honour position of cycle window when icons are showing...

;; Thanks to Christian Marillat, Barthel(?) and Guillermo S. Romero for
;; bug reports, patches and suggestions.

(define-structure merlin.ugliness

  (export
   ugly-cycle-show-window-list
   ugly-cycle-hide-window-list)

  (open
   rep
   rep.io.files
   sawfish.wm.colors
   sawfish.wm.custom
   sawfish.wm.fonts
   sawfish.wm.images
   sawfish.wm.misc
   sawfish.wm.commands.move-resize
   sawfish.wm.commands.x-cycle
   sawfish.wm.util.x
   sawfish.wm.windows.subrs
   merlin.message
   merlin.util
   merlin.uglicon)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; x-cycle basic appearance settings
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defgroup focus-ugliness "Ugliness" :group focus)

  (defcustom ugly-cycle-show-windows t
    "Display full list of window names in cycle ring."
    :group (focus focus-ugliness)
    :type boolean)

  (defcustom ugly-cycle-relative 'screen
    "Display cycle list relative to: \\w"
    :type symbol
    :options (screen window)
    :group (focus focus-ugliness))

  (defcustom ugly-cycle-percent (cons 50 50)
    "Offset of cycle list as percentage of parent dimensions."
    :type (pair (labelled "Horizontal:" (number 0 100)) (labelled "Vertical:" (number 0 100)))
    :group (focus focus-ugliness))

  (defcustom ugly-cycle-color (cons (get-color "black") (get-color "white"))
    "Window cycle list color."
    :type (pair (labelled "Foreground:" color) (labelled "Background:" color))
    :group (focus focus-ugliness))

  (defcustom ugly-cycle-font default-font
    "Font for cycle list."
    :type font
    :group (focus focus-ugliness))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; x-cycle advanced ugliness settings
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defgroup focus-extra-ugliness "Extra Ugliness" :group focus)

  (defcustom ugly-cycle-justify 'center
    "Justification of window names."
    :type symbol
    :options (left center right)
    :group (focus focus-extra-ugliness))

  (defcustom ugly-cycle-current-foreground (get-color "red")
    "Foreground color for currently-selected window."
    :type color
    :group (focus focus-extra-ugliness))

  (defcustom ugly-cycle-current-font default-font
    "Font for currently-selected window."
    :type font
    :group (focus focus-extra-ugliness))

  (defcustom ugly-cycle-iconified-foreground (get-color "blue")
    "Foreground color for iconified windows."
    :type color
    :group (focus focus-extra-ugliness))

  (defcustom ugly-cycle-iconified-font default-font
    "Font for iconified windows."
    :type font
    :group (focus focus-extra-ugliness))

  (defcustom ugly-cycle-caption t
    "Display current window name in caption."
    :group (focus focus-extra-ugliness)
    :type boolean)

  (defcustom ugly-cycle-caption-foreground (get-color "white")
    "Foreground color for caption."
    :type color
    :group (focus focus-extra-ugliness)
    :depends ugly-cycle-caption)

  (defcustom ugly-cycle-caption-font default-font
    "Font for caption."
    :type font
    :group (focus focus-extra-ugliness)
    :depends ugly-cycle-caption)

  (defcustom ugly-cycle-border (cons 2 (get-color "black"))
    "Border around window list."
    :type (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color))
    :group (focus focus-extra-ugliness))

  (defcustom ugly-cycle-padding (cons 4 4)
    "Padding around window list."
    :type (pair (labelled "Horizontal:" (number 0 100)) (labelled "Vertical:" (number 0 100)))
    :group (focus focus-extra-ugliness))

  (defcustom ugly-cycle-gravity 'center
    "Gravity of window list."
    :type symbol
    :options
    (north-west north north-east west center east south-west south south-east)
    :group (focus focus-extra-ugliness))

  ;;;;;;;;;;;;;;;;;;;;;;;;
  ;; my ugly display stuff
  ;;;;;;;;;;;;;;;;;;;;;;;;

  (define (ugly-cycle-display-position win)
    (if (eq ugly-cycle-relative 'window)
	(cons+ (window-position win) (cons-percent (window-frame-dimensions win) ugly-cycle-percent))
      (cons-percent (screen-dimensions) ugly-cycle-percent)))

  (define (justify child parent)
    (cond ((eq ugly-cycle-justify 'left) 0)
          ((eq ugly-cycle-justify 'right) (- parent child))
          (t (quotient (- parent child) 2))))

  (let (ugly-w ugly-g width height rectangle icons labels)
    (define (ugly-cycle-show win win-list) ;; bleargh!!!
      (setq width 0 height 0 rectangle nil icons nil labels nil)
      (if cycle-show-window-icons
(let* ;; just hideous; tidy this all up??
((fonts (list* ugly-cycle-current-font ugly-cycle-iconified-font ugly-cycle-font))
 (th (apply max 0 (mapcar (lambda (f) (font-height f)) fonts)))
 (mi (min (length win-list) (quotient (- (screen-width) (car ugly-cycle-padding) (* 2 (car ugly-cycle-border))) (+ uglicon-width (car ugly-cycle-padding)))))
 (iw (+ (* mi uglicon-width) (* (1- mi) (car ugly-cycle-padding)))))
          (setq
            width (apply max iw (and ugly-cycle-caption (mapcar (lambda (w) (text-width (window-name w) ugly-cycle-caption-font)) win-list)))
            height (+ height (* (+ uglicon-height th) (ceil (length win-list) mi)))
            labels
              (mapcar
                (lambda (w)
                  (let*
                      ((iconified (window-get w 'iconified))
                       (font (if (eq w win) ugly-cycle-current-font (if iconified ugly-cycle-iconified-font ugly-cycle-font)))
                       (color (if (eq w win) ugly-cycle-current-foreground (if iconified ugly-cycle-iconified-foreground (car ugly-cycle-color))))
                       (text (trim (window-name w) font uglicon-width))
                       (icon (get-window-icon w #:fade-to (and iconified (cdr ugly-cycle-color))))
                       (index (index-of w win-list))
                       (pos (cons+ (cons* (cons%/ index mi) (cons (+ uglicon-width (car ugly-cycle-padding)) (+ uglicon-height th))) (cons (justify iw width) 0) ugly-cycle-padding))
                       (ipos (cons+ pos (cons-quotient (cons- (cons uglicon-width uglicon-height) (image-dimensions icon)) 2)))
                       (tpos (cons+ pos (cons (justify (text-width text font) uglicon-width) (+ uglicon-height (- th (font-descent font)))))))
                    (when (eq win w)
                      (setq rectangle (list color (cons- pos 1) (cons+ (cons uglicon-width (+ uglicon-height th)) 1))))
                    (setq icons (list* (list icon ipos) icons))
                    (list color tpos text font))) win-list)))
(let*
((fonts (list* ugly-cycle-current-font ugly-cycle-iconified-font ugly-cycle-font (and ugly-cycle-caption (list ugly-cycle-caption-font)))))
        (setq
          width (apply max 0 (mapcar (lambda (w) (apply max 0 (mapcar (lambda (f) (text-width (window-name w) f)) fonts))) win-list)) ; + 2*padding
          labels
            (mapcar
              (lambda (w)
                (let*
                    ((iconified (window-get w 'iconified))
                     (font (if (eq w win) ugly-cycle-current-font (if iconified ugly-cycle-iconified-font ugly-cycle-font)))
                     (color (if (eq w win) ugly-cycle-current-foreground (if iconified ugly-cycle-iconified-foreground (car ugly-cycle-color))))
                     (text (window-name w))
                     (pos (cons+ (cons (justify (text-width text font) width) (+ height (font-ascent font))) ugly-cycle-padding)))
                  (setq height (+ height (font-height font))) ; font-height?
                  (list color pos text font))) win-list))))
      (when ugly-cycle-caption
        (let*
            ((text (window-name win))
             (font ugly-cycle-caption-font)
             (color ugly-cycle-caption-foreground)
             (pos (cons+ (cons (justify (text-width text font) width) (+ height (cdr ugly-cycle-padding) (font-ascent font))) ugly-cycle-padding)))
          (setq height (+ height (cdr ugly-cycle-padding) (font-height font))) ; font-height?
          (setq labels (nconc labels (list (list color pos text font))))))
      (setq width (+ width (* 2 (car ugly-cycle-padding))) height (+ height (* 2 (cdr ugly-cycle-padding))))
      (let*
          ((dim (cons+ (cons width height) (* 2 (car ugly-cycle-border))))
           (pos (cons-max (cons-min (gravitate (ugly-cycle-display-position win) dim ugly-cycle-gravity) (cons- (screen-dimensions) dim)) 0))
           (repaint
             (lambda ()
               (x-clear-window ugly-w)
               (when rectangle
                 (x-change-gc ugly-g `((foreground . ,(nth 0 rectangle))))
                 (x-draw-rectangle ugly-w ugly-g (nth 1 rectangle) (nth 2 rectangle)))
               (mapc
                 (lambda (icon)
                   (x-draw-image (nth 0 icon) ugly-w (nth 1 icon))) icons)
               (mapc
                 (lambda (label)
                   (x-change-gc ugly-g `((foreground . ,(nth 0 label))))
                   (x-draw-string ugly-w ugly-g (nth 1 label) (nth 2 label) (nth 3 label))) labels))))
	(if ugly-w
	    (x-configure-window ugly-w
				`((x . ,(car pos))
				  (y . ,(cdr pos))
				  (width . ,width)
				  (height . ,height)
				  (stack-mode . top-if)))
	  (setq ugly-w (x-create-window
			pos (cons width height) (car ugly-cycle-border)
			`((background . ,(cdr ugly-cycle-color))
			  (border-color . ,(cdr ugly-cycle-border))
			  (override-redirect . ,t)
			  (save-under . ,nil)
			  (event-mask . ,'(exposure)))
			repaint)
		ugly-g (x-create-gc
			ugly-w
			`((background . ,(cdr ugly-cycle-color)))))
	  (x-map-window ugly-w t))
	(repaint)))
                   
    (define (ugly-cycle-hide)
      (when ugly-w
	(x-destroy-window ugly-w)
	(setq ugly-w nil))
      (when ugly-g
	(x-destroy-gc ugly-g)
	(setq ugly-g nil))))

  ;; function proxy

  (define (ugly-cycle-show-window-list win win-list)
    (ugly-cycle-show win (if ugly-cycle-show-windows win-list (list win))))

  (define (ugly-cycle-hide-window-list)
    (ugly-cycle-hide))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; x-cycle ugly display stuff
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (eval-in
   `(progn
      (require 'merlin.ugliness)

      ;; an awful thing, copied from x-cycle.jl
      (define (ugly-cycle-windows)
	(let
	    ((win (window-order (if cycle-all-workspaces nil current-workspace)
				cycle-include-iconified cycle-all-viewports)))
	  (unless (eq (fluid x-cycle-windows) t)
	    (setq win (delete-if (lambda (w)
				   (not (memq w (fluid x-cycle-windows)))) win)))
	  (setq win (delete-if-not window-in-cycle-p win))))

      (define (cycle-display-message)
        (ugly-cycle-show-window-list (fluid x-cycle-current) (ugly-cycle-windows)))

      (define (remove-message)
        (ugly-cycle-hide-window-list)))

   'sawfish.wm.commands.x-cycle)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; move-resize basic ugliness settings
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defgroup move-ugliness "Ugliness" :group move)

  (defcustom ugly-move-resize-relative 'window
    "Display move/resize coordinates relative to: \\w"
    :type symbol
    :options (screen window)
    :group (move move-ugliness))

  (defcustom ugly-move-resize-percent (cons 50 50)
    "Offset of move/resize coordinates as percentage of parent dimensions."
    :type (pair (labelled "Horizontal:" (number 0 100)) (labelled "Vertical:" (number 0 100)))
    :group (move move-ugliness))

  (defcustom ugly-move-resize-color (cons (get-color "black") (get-color "white"))
    "Move/resize coordinates color."
    :type (pair (labelled "Foreground:" color) (labelled "Background:" color))
    :group (move move-ugliness))

  (defcustom ugly-move-resize-font default-font
    "Font for move/resize coordinates."
    :type font
    :group (move move-ugliness))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; move-resize advanced ugliness settings
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defgroup move-extra-ugliness "Extra Ugliness" :group move)

  (defcustom ugly-move-resize-border (cons 2 (get-color "black"))
    "Border around move-resize coordinates."
    :type (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color))
    :group (move move-extra-ugliness))

  (defcustom ugly-move-resize-padding (cons 4 4)
    "Padding around move-resize coordinates."
    :type (pair (labelled "Horizontal:" (number 0 100)) (labelled "Vertical:" (number 0 100)))
    :group (move move-extra-ugliness))

  (defcustom ugly-move-resize-gravity 'center
    "Gravity of move-resize coordinates."
    :type symbol
    :options
    (north-west north north-east west center east south-west south south-east)
    :group (move move-extra-ugliness))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; move-resize ugly display stuff
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (eval-in
   `(progn
      (require 'merlin.message)
      (require 'merlin.util)

      (define (ugly-move-resize-display-message msg)
	(let*
	    ((pos (if (eq ugly-move-resize-relative 'window)
		      (cons+ (cons move-resize-x move-resize-y)
			     (cons-percent (cons+ move-resize-frame (cons move-resize-width move-resize-height)) ugly-move-resize-percent))
		    (cons-percent (screen-dimensions) ugly-move-resize-percent)))
	     (attrs `((position . ,pos)
		      (font . ,ugly-move-resize-font)
		      (foreground . ,(car ugly-move-resize-color))
		      (background . ,(cdr ugly-move-resize-color))
		      (border-color . ,(cdr ugly-move-resize-border))
		      (border-width . ,(car ugly-move-resize-border))
		      (padding . ,ugly-move-resize-padding)
		      (gravity . ,ugly-move-resize-gravity)
		      (spacing . ,0))))
	  (fancy-message (list msg) attrs)))

      (define (display-message msg)
	(if msg
	    (ugly-move-resize-display-message msg)
	  (hide-fancy-message))))

   'sawfish.wm.commands.move-resize))
