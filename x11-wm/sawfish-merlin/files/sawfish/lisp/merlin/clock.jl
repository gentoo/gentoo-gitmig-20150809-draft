;; merlin/clock.jl -- a bad clock

;; version -0.2

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

;;;;;;;;;;;;;;;;;;;;;
;; HERE BE DRAGONS ;;
;;;;;;;;;;;;;;;;;;;;;

;; This software requires a patch to be applied to the Sawfish source to
;; add some additional XLib bindings.

;; Please see x.c.patch.

;;;;;;;;;;;;;;;;;;
;; INSTALLATION ;;
;;;;;;;;;;;;;;;;;;

;; Create a directory ~/.sawfish/lisp/merlin and then put this file there:
;;   mkdir -p ~/.sawfish/lisp/merlin
;;   mv clock.jl ~/.sawfish/lisp/merlin

;; You also need merlin/sawlet.jl, merlin/util.jl and merlin/x-util.jl.

;; You're probably best off unpacking the entire merlin.tgz archive.

;; Then add to your .sawfishrc:
;;   (require 'merlin.clock)
;;   (defclock clock)

;; Then restart sawfish. A clock should appear in the top left corner
;; of your screen.

;; Go to Customize->Matched Windows->Sawlet/clock->Edit...
;;      - Here you can specify a position for the window, border type, etc.
;; Also go to Customize->Sawlets->Clock
;;      - Here you can customize the behaviour of the clock. 

;; You can create multiple clocks and can configure them programatically
;; at creation if you want..

;;;;;;;;;;;;;;;;;;
;; HERE BE BUGS ;;
;;;;;;;;;;;;;;;;;;

;; one has to ask... why?

;;;;

(define-structure merlin.clock
  (export
   defclock)

  (open
   rep
   rep.regexp
   rep.system
   rep.io.timers
   sawfish.wm.custom
   sawfish.wm.fonts
   sawfish.wm.images
   sawfish.wm.misc
   sawfish.wm.ext.tooltips
   sawfish.wm.util.x
   merlin.sawlet)

  ;;

  (define (dimensions clock)
    (let ((dim (drawable-dimensions clock)))
      (if (eq 'vertical (sawlet-config clock 'orientation))
        (cons (cdr dim) (car dim)) dim)))

  (define (drawable-dimensions clock) ; TODO: need XTextExtents...
    (cons (sawlet-config clock 'breadth)
          (+ (font-ascent (sawlet-config clock 'font)) 3))) ;; descent

  (define format-matches ; TODO: ignore %%evil
    `(("%(c|Ec|r|s|S|OS|T|X|EX|\\+)" . 1)
      ("%(M|OM|R)" . 60)
      ("%(H|OH|I|OI|k|l)" . 3600)))

  (define (clock-granularity clock)
    (let
        ((format (sawlet-config clock 'format))
         (cache (sawlet-get clock 'granularity)))
      (cdr (or (and (equal (car cache) format) cache)
        (sawlet-put clock 'granularity
          (cons
            format
            (catch 'out
              (mapc (lambda (match)
                (when (string-match (car match) format)
                 (throw 'out (cdr match)))) format-matches)
              86400)))))))

  (define (start clock)
    (sawlet-put clock 'drawable
      (x-create-pixmap (drawable-dimensions clock))
      x-destroy-drawable)
    (timeout clock))

  (define (stop clock)
    (sawlet-put clock 'timer nil delete-timer)
    (sawlet-put clock 'drawable nil x-destroy-drawable)
    (sawlet-put clock 'image nil))

  (define (expose-handler clock event)
    (let
        ((image (sawlet-get clock 'image))
         (window (sawlet-get clock 'window)))
      (and image (x-draw-image image window (cons 0 0)))))

  (define (button-press-handler clock event))

  (define (enter-notify-handler clock event)
    (let ((tooltips-enabled t))
      (display-tooltip-after-delay (current-time-string)
        (sawlet-frame clock))))

  (define (timeout clock)
    (let*
	((window (sawlet-get clock 'window))
         (drawable (sawlet-get clock 'drawable))
         (gc (sawlet-get clock 'gc))
         (font (sawlet-config clock 'font))
         (dims (drawable-dimensions clock))
         (background (sawlet-config clock 'background))
         (foreground (sawlet-config clock 'foreground))
         (time (current-time-string nil (sawlet-config clock 'format)))
         (x (quotient (- (car dims) (text-width time font)) 2))
	 (y (font-ascent font))
         (granularity (clock-granularity clock))
	 image)
      (x-change-gc gc `((foreground . ,background)))
      (x-fill-rectangle drawable gc (cons 0 0) dims)
      (x-change-gc gc `((foreground . ,foreground)))
      (x-draw-string drawable gc (cons x y) time font)
      (setq image (make-image-from-x-drawable (x-window-id drawable)))
      (when (eq 'vertical (sawlet-config clock 'orientation))
        (flip-image-vertically image)
        (flip-image-diagonally image))
      (sawlet-put clock 'image image)
      (expose-handler clock nil)
      ; TODO: figure out finer grained now to catch second change more accurately
      (sawlet-put clock 'timer
        (make-timer
          (lambda ()
            (timeout clock))
          (- granularity (% (cdr (current-time)) granularity)) 0) delete-timer)))

  ;;

  (defmacro defclock (clock . keys)
    `(progn
      (require 'merlin.sawlet)
      ,(append
        `(defsawlet ,clock)
        keys ; allow override
        `(:start ,start
        :stop ,stop
        :pre-configure ,stop
        :post-configure ,start
        :dimensions ,dimensions
        :expose-handler ,expose-handler
        :button-press-handler ,button-press-handler
        :enter-notify-handler ,enter-notify-handler
        :defcustom (orientation 'vertical
          "Orientation."
          :type (choice vertical horizontal)
          :after-set sawlet-reconfigure)
        :defcustom (breadth 64
          "Breadth."
          :type (number 1 1024)
          :after-set sawlet-reconfigure)
        :defcustom (format "%H:%M:%S"
          "Display format."
          :tooltip "Format (a text string containing escapes):\n  %H = hour (00..23)\n  %l = hour ( 1..12)\n  %M = minute (00..59)\n  %S = second (00..60)\n  %y = year (00..99)\n  %m = month (01..12)\n  %d = day of month (01..31)\netc. (man 3 strftime)"
          :type string
          :after-set sawlet-reconfigure))))))
