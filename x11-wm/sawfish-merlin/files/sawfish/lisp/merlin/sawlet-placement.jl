;; merlin/sawlet-placement.jl -- a placement mode for sawlets etc.

;; version 0.3

;; Copyright (C) 2000-2001 merlin <merlin@merlin.org>

;; http://merlin.org/sawfish/

;; This is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This is distributed in the hope that it will be useful, but
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
;;   mv sawlet-placement.jl ~/.sawfish/lisp/merlin

;; You also need merlin/util.jl.

;; You're probably best off unpacking the entire merlin.tgz archive.

;; Then add to your .sawfishrc:
;;   (require 'merlin.sawlet-placement)
;;   (define-sawlet-placement-mode 'south-east-going-north
;;     'south-east 'north)

;; This defines a placement mode 'south-east-going-north that starts
;; in the south-east of your screen and moves northwards. You can
;; choose whatever name you want, and define as many sawlet placement
;; modes as you want. Your options include 'north-west, 'north-east,
;; 'south-east and 'south-west, going 'north, 'south, 'east or 'west.

;; Next, try adding:
;;   (define-sawlet-subplacement-mode 'south-east-going-west
;;     'south-east-going-north nil 'west)

;; This defines a placement mode 'south-east-going-west which is
;; treated as a composite child (with the specified placement weight)
;; of 'south-east-going-north. The two placement modes try and act
;; harmoniously, allowing you to have automatic window placement
;; as such:
;;                 [SEgN]
;;                 [SEgN]
;;   [SEgW] [SEgW] [SEgW]

;; More complex arrangements are also possible.

;; Then restart sawfish.

;; Go to Customize->Matched Windows
;;   - Here you must add matchers on any windows that you want
;;     (e.g., XBiff, XClock) for your new Place mode. Also, you
;;     can use the Placement weight setting to assert an order
;;     on the sawlets (least first); otherwise they are placed
;;     in the order that they happen to be picked up by sawfish.

;; Now, launch the apps. Or, if they launch at startup, restart
;; your X session.

;;;;;;;;;;;;;;;;;;
;; HERE BE BUGS ;;
;;;;;;;;;;;;;;;;;;

;; I don't wrap around when I come to the edge of the screen...

;; See merlin.pager for a probable problem with merging/removing
;; workspaces.

;; Subplacements should try to pack windows better rather than
;; assuming pessimistic overlap with consequent full avoidance.

;;;;

(define-structure merlin.sawlet-placement
  (export
  get-size
   define-sawlet-placement-mode
   define-sawlet-subplacement-mode)

  (open
   rep
   rep.system
   sawfish.wm.events
   sawfish.wm.misc
   sawfish.wm.placement
   sawfish.wm.viewport
   sawfish.wm.windows
   merlin.util)

  (define modes nil)

  (define (origin mode)
    (let*
        ((origin (get mode 'merlin.sawlet-placement:origin)))
      (cons (if (memq origin '(north-east south-east)) 1 0)
            (if (memq origin '(south-west south-east)) 1 0))))

  (define (direction mode)
    (let*
        ((direction (get mode 'merlin.sawlet-placement:direction)))
      (cond
        ((eq direction 'east) (cons 1 0))
        ((eq direction 'west) (cons -1 0))
        ((eq direction 'north) (cons 0 -1))
        (t (cons 0 1)))))

  (define (gravity mode)
    (let*
        ((direction (get mode 'merlin.sawlet-placement:direction))
         (org (origin mode)))
      (cond ;; yech
        ((eq direction 'east) (cons 0 (- (cdr org))))
        ((eq direction 'west) (cons -1 (- (cdr org))))
        ((eq direction 'north) (cons (- (car org)) -1))
        (t (cons (- (car org)) 0)))))

  (define (placement-p placement)
    (and (symbolp placement) (get placement 'merlin.sawlet-placement:direction)))

  (define (subplacement-p placement)
    (and (symbolp placement) (get placement 'merlin.sawlet-placement:parent)))

  (define (get-placement x)
    (if (subplacement-p x)
        (get x 'merlin.sawlet-placement:parent)
      (window-get x 'place-mode)))

  (define (get-weight x)
    (or
      (if (subplacement-p x)
          (get x 'merlin.sawlet-placement:weight)
        (window-get x 'placement-weight))
      -1))

  (define (visible-p window)
    (and (window-mapped-p window) (window-visible-p window)
      (or (window-get window 'sticky-viewport)
        (not (window-outside-viewport-p window)))))

  ;; TODO: make multiple dependent placement modes be smart about
  ;; just not overlapping windows; not to always be pessimistic

  ;; TODO: honour origin of subplacements...

  (define (get-size x)
    (if (not (placement-p x))
        (if (visible-p x) (window-frame-dimensions x) (cons 0 0))
      (let*
          ((direction (get x 'merlin.sawlet-placement:direction))
           (sawlets (get x 'merlin.sawlet-placement:list))
           (sizes (mapcar get-size sawlets))
           (op (if (memq direction '(east west)) (cons + max) (cons max +))))
        (apply cons-op op (cons 0 0) sizes))))

  (define (mode-place mode pos)
    (let*
        ((sawlets (get mode 'merlin.sawlet-placement:list))
         (org (origin mode))
         (dir (direction mode))
         (grv (gravity mode)))
      (mapc
        (lambda (sawlet)
          (if (placement-p sawlet)
              (mode-place sawlet pos)
            (when (visible-p sawlet)
              (let*
                  ((dim (window-frame-dimensions sawlet))
                   (tmp (cons+ pos (cons* grv dim))))
                (move-window-to sawlet (car tmp) (cdr tmp)))))
          (setq pos
            (cons+ pos (cons* dir (get-size sawlet)))))
        sawlets)))

  (define (place x)
    (let*
        ((mode (let loop ((mode (get-placement x))) (if (not (subplacement-p mode)) mode (loop (get-placement mode)))))
         (pos (cons* (origin mode) (screen-dimensions))))
      (mode-place mode pos)))

  (define (add-window-eye window)
    (let*
        ((mode (get-placement window))
         (weight (get-weight window))
         (sawlets (cons nil (and mode (get mode 'merlin.sawlet-placement:list)))))
      (when (memq mode modes)
        (let loop ((rest sawlets))
          (if (or (null (cdr rest)) (> (get-weight (cadr rest)) weight))
              (rplacd rest (cons window (cdr rest)))
            (loop (cdr rest))))
        (put mode 'merlin.sawlet-placement:list (cdr sawlets)))))

  (define (destroy-notify-eye window)
    (let*
        ((mode (get-placement window))
         (sawlets (and mode (get mode 'merlin.sawlet-placement:list)))
         (next (cadr (memq window sawlets))))
      (when sawlets
        (put mode 'merlin.sawlet-placement:list (delq window sawlets))
        (when next
          (place next))))) ;; TODO: must replace ALWAYS if it is subplaced

  (define (window-resized-eye window)
    (let*
        ((mode (get-placement window)))
      (when (placement-p mode)
        (place window))))

  (define (after-initialization-eye)
    (mapc
      (lambda (mode)
        (let*
            ((sawlets (get mode 'merlin.sawlet-placement:list))
             (first (car sawlets)))
          (when (and first (not (subplacement-p mode)))
            (place first))))
      modes))

  (add-hook 'add-window-hook add-window-eye)

  (add-hook 'destroy-notify-hook destroy-notify-eye)

  (mapc (lambda (hook) (add-hook hook window-resized-eye))
    '(window-resized-hook after-framing-hook map-notify-hook
      unmap-notify-hook iconify-window-hook uniconify-window-hook
      window-maximized-hook window-unmaximized-hook))

  (mapc (lambda (hook) (add-hook hook after-initialization-eye))
    '(after-initialization-hook enter-workspace-hook
      viewport-moved-hook))

  (define (define-sawlet-subplacement-mode symbol parent weight direction)
    (when (memq symbol modes) ;; TODO: Allow redefinition
      (error "placement mode %s is already defined." symbol))
    (unless (placement-p parent)
      (error "parent placement mode %s must be defined." parent))
    (define-sawlet-placement-mode symbol (get parent 'merlin.sawlet-placement:origin) direction)
    (put symbol 'merlin.sawlet-placement:parent parent)
    (put symbol 'merlin.sawlet-placement:weight weight)
    (add-window-eye symbol))

  (define (define-sawlet-placement-mode symbol origin direction)
    (put symbol 'merlin.sawlet-placement:origin origin)
    (put symbol 'merlin.sawlet-placement:direction direction)
    (if (memq symbol modes)
        (mapc place (get symbol 'merlin.sawlet-placement:list))
      (setq modes (nconc modes (list symbol))))
    (define-placement-mode symbol place)))
