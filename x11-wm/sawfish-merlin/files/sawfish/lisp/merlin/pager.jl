;; merlin/pager.jl -- a bad pager

;; version -0.91.1

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
;;   mv pager.jl ~/.sawfish/lisp/merlin

;; You also need merlin/sawlet.jl, merlin/util.jl and merlin/x-util.jl.

;; You're probably best off unpacking the entire merlin.tgz archive.

;; Then add to your .sawfishrc:
;;   (require 'merlin.pager)
;;   (defpager pager)

;; Then restart sawfish. A pager should appear in the top right corner
;; of your screen.

;; Go to Customize->Sawlets->Pager
;;   - Here you can customize the behaviour of the pager
;; Also go to Customize->Matched Windows->^Sawlet/pager$->Edit...
;;   - Here you can specify a border type for the window, etc.

;; You can create multiple icon boxes and can configure them programatically
;; at creation if you want.. but you probably don't..

;;;;;;;;;;;;;;;;;;
;; HERE BE BUGS ;;
;;;;;;;;;;;;;;;;;;

;; I divide window dimensions instead of dividing window bounds..
;; but it looks better.

;; Dragging a win from the very edge can leave the pager with
;; the wrong idea of who is focused at the end of the drag
;; because I suppress enter/leave notification. I could store
;; the last enter/leave notification to resend it after the
;; drag is finished... todo.

;; Dragging a win from the very edge sometimes appears to lose
;; hold of the window. But this could be just a gammy mouse button.

;; The pager does not keep up with merging workspaces.. I just
;; hear a 'workspace-state-changed which is too common for me
;; to do a full rebuild on.. In fact, I think this is a bug in
;; remove-workspace: It does not emit enter-workspace,
;; add-to-workspace or remove-from-workspace. Perhaps I could
;; fix this by noticing changes on the 'workspace* property of
;; windows?

;; If you toggle a window 'ignored (and maybe 'sticky, etc.)
;; I don't pick up on it. I'm not sure that I care.

;; TODO: use icon name

;; TODO: support a delay before drags warp into the pager.

;;;;

(define-structure merlin.pager

  (export
   defpager)

  (open
   rep
   rep.system
   rep.io.timers
   sawfish.wm.colors
   sawfish.wm.custom
   sawfish.wm.events
   sawfish.wm.fonts
   sawfish.wm.menus
   sawfish.wm.misc
   sawfish.wm.stacking
   sawfish.wm.viewport
   sawfish.wm.windows
   sawfish.wm.workspace
   sawfish.wm.commands.move-resize
   sawfish.wm.ext.tooltips
   sawfish.wm.state.iconify
   sawfish.wm.util.display-window
   sawfish.wm.util.x
   merlin.sawlet
   merlin.util
   merlin.x-util)

  (defvar viewport-xy (viewport-offset)) ;; ughlobals, can probably do better
  (define during-restack nil)

  ;;;;

  (define (fix-position pager pos)
    (cons-quotient (cons+ pos (viewport-offset))
      (sawlet-config pager 'divisor)))

  (define (fix-dimensions pager dim bw)
    (let
        ((divisor (sawlet-config pager 'divisor)))
      (cons-max (cons- (cons-quotient (cons+ dim (cons- divisor 1))
        divisor) (* 2 bw)) 0)))

  (define (dimensions pager)
    (fix-dimensions pager
      (cons* viewport-dimensions (screen-dimensions)) 0))

  (define (viewport-position pager)
    (fix-position pager (cons 0 0)))

  (define (viewport-dimensionz pager)
    (fix-dimensions pager (screen-dimensions)
      (car (sawlet-config pager 'viewport-border))))

  (define (win-foo pager window foo)
    (sawlet-config pager
      (if (eq window (input-focus))
          (intern (format nil "focused-%s" foo))
        foo)))

  (define (win-position pager window)
    (fix-position pager (window-position window)))

  (define (win-dimensions pager window)
    (fix-dimensions pager (window-frame-dimensions window)
      (car (win-foo pager window 'win-border))))

  ;;;;

  (define (win-button-press-handler pager event)
    (remove-tooltip)
    (let*
	((win (cdr (assq 'window event)))
	 (window (x-window-get win 'window))
	 (xy (cons (cdr (assq 'x event)) (cdr (assq 'y event))))
	 (time (cdr (assq 'time event)))
	 (button (cdr (assq 'button event))))
      (cond
	((and (eq button 'button-1) (not (eq window (sawlet-frame pager))))
          (if (and (eq win (sawlet-get pager 'old-drag-win))
                   (< (- time (sawlet-get pager 'drag-time)) 333))
	      (display-window window)
            (sawlet-put pager 'drag-win win)
            (sawlet-put pager 'drag-time time)
	    (sawlet-put pager 'drag-xy xy)
	    (when (and (eq focus-mode 'click)
		       (window-really-wants-input-p window))
	      (set-input-focus window))))
	 ((eq button 'button-3)
	  (current-event-window window)
	  (popup-window-menu window)))))

; BUG: If I click, then drag one pixel, then wait, then I
; lose the focus... Also, that first drag event doesn't
; result in the window moving... Obviously because I wait
; until I get that motion before I _start_ the interactive
; move.

  (define (win-motion-notify-handler pager event)
    (let*
        ((win (cdr (assq 'window event)))
         (window (x-window-get win 'window))
         (xy (cons (cdr (assq 'x event)) (cdr (assq 'y event)))))
      (when (eq win (sawlet-get pager 'drag-win))
        (win-button-release-handler pager event) ;; stop multiple moves
        (setq
          move-window-unconstrained t
          move-window-initial-pointer-offset
            (cons-max 0
              (cons* (sawlet-config pager 'divisor)
                (cons+ (sawlet-get pager 'drag-xy)
                  (car (win-foo pager window 'win-border))))))
        (move-window-interactively window))))

  (define (win-button-release-handler pager event)
    (sawlet-put pager 'drag-win nil
      (lambda (win) (sawlet-put pager 'old-drag-win win))))

  (define (win-enter-notify-handler pager event)
    (let*
	((win (cdr (assq 'window event)))
	 (window (x-window-get win 'window)))
      (unless (sawlet-get pager 'drag-win)
        (let ((tooltips-enabled t))
          (display-tooltip-after-delay (window-name window) window))
        (call-hook 'enter-notify-hook (list window 'normal)))))

  (define (win-leave-notify-handler pager event)
    (let*
	((win (cdr (assq 'window event)))
	 (window (x-window-get win 'window)))
      (unless (sawlet-get pager 'drag-win)
        (call-hook 'leave-notify-hook (list window 'normal)))))

  (define (win-repaint pager win)
    (let*
	((window (x-window-get win 'window))
         (gc (sawlet-get pager 'gc))
	 (title (window-name window))
         (font (win-foo pager window 'win-font)))
      (x-clear-window win)
      (x-change-gc gc `((foreground . ,(car (win-foo pager window 'win-color)))))
      (x-draw-string win gc (cons 1 (font-ascent font)) title font)))
    
  (define (win-expose-handler pager event)
    (win-repaint pager (cdr (assq 'window event))))

  (define win-event-handlers
    `((button-press . ,win-button-press-handler)
      (motion-notify . ,win-motion-notify-handler)
      (button-release . ,win-button-release-handler)
      (enter-notify . ,win-enter-notify-handler)
      (leave-notify . ,win-leave-notify-handler)
      (expose . ,win-expose-handler)))

  (define (win-event-handler type window event)
    (let
        ((handler (assq type win-event-handlers)))
      (when handler
        ((cdr handler) (x-window-get window 'sawlet) event))))

  (define (win-reconfigure pager win)
    (let*
        ((window (x-window-get win 'window))
         (pos (win-position pager window))
         (dim (win-dimensions pager window))
         (border (win-foo pager window 'win-border)))
      (x-configure-window
        win
        `((x . ,(car pos))
          (y . ,(cdr pos))
          (width . ,(car dim))
          (height . ,(cdr dim))
          (border-width . ,(car border))))
      (x-change-window-attributes
        win
        `((background . ,(cdr (win-foo pager window 'win-color)))
          (border-color . ,(cdr border))))
      (win-repaint pager win)))
        
  ;;;;

  (define (window-moved-eye pager window)
    (when (or (equal viewport-xy (viewport-offset))
	      (window-get window 'sticky-viewport))
      (let*
	  ((win (window-get window (sawlet-symbol pager 'win))))
        (when win
          (let*
              ((pos (win-position pager window))
               (dim (win-dimensions pager window)))
            (x-configure-window
              win
              `((x . ,(car pos))
                (y . ,(cdr pos))
                (width . ,(car dim))
                (height . ,(cdr dim)))))))))

  (define (after-add-window-eye pager window)
    (unless (or (window-get window 'ignored) (window-get window (sawlet-symbol pager 'win))) ;; HACK
      (let*
	  ((border (win-foo pager window 'win-border))
           (win
             (x-create-window
               (win-position pager window)
               (win-dimensions pager window)
               (car border)
               `((parent . ,(sawlet-get pager 'window))
                 (background . ,(cdr (win-foo pager window 'win-color)))
                 (border-color . ,(cdr border))
                 (override-redirect . t)
                 (event-mask . (button-press button-release button-motion
				enter-window leave-window exposure)))
               win-event-handler)))
        (x-window-put win 'sawlet pager)
        (x-window-put win 'window window)
        (window-put window (sawlet-symbol pager 'win) win)
        (when (and (window-mapped-p window) (window-visible-p window))
          (x-x-map-window win)))))

  ; could do this more efficiently with better hooks
  (define (after-restacking-eye pager)
    (unless during-restack
      (let*
	  ((wins (delq nil
                   (mapcar
                     (lambda (window)
                       (window-get window (sawlet-symbol pager 'win)))
                     (stacking-order)))))
	(setq during-restack t)
	(unwind-protect
	  (when (car wins)
            (x-x-raise-window (car wins))) ;; hack
	      ;; that is a weird hack that i don't understand.
	      ;; essentially what happens is I have a big emacs
	      ;; window on the left completely covering an xterm.
	      ;; lower emacs and the xterm appears on top in the
	      ;; pager, as it should. then raise the xterm. its
	      ;; pager window disappears behind the emacs pager
	      ;; window. examining the calls, I am (apparently)
	      ;; correctly calling XRestackWindows but it is not
	      ;; doing what I expect.
	  (x-restack-windows wins))
	(setq during-restack nil))))

  ;; ?? window-mapped-p and window-visible-p
  (define (map-notify-eye pager window)
    (let*
        ((win (window-get window (sawlet-symbol pager 'win))))
      (when win
        (if (and (window-visible-p window) (window-mapped-p window))
            (x-x-map-window win)
          (x-unmap-window win)))))

  (define (enter-workspace-eye pager)
    (stop pager)
    (start pager))

  (define (viewport-moved-eye pager)
    (post-configure pager)) ;; heavier than necessary

  (define (viewport-resized-eye pager)
    (sawlet-reconfigure pager)) ;; heavier than necessary

  (define (focus-in-eye pager window)
    (let*
        ((win (window-get window (sawlet-symbol pager 'win))))
      (when win
        (win-reconfigure pager win))))

  (define (focus-out-eye pager window)
    (let*
        ((win (window-get window (sawlet-symbol pager 'win))))
      (when win
        (win-reconfigure pager win))))

  (define (property-notify-eye pager window property state)
    (let*
        ((win (window-get window (sawlet-symbol pager 'win))))
      (when (and win (eq property 'WM_NAME))
	(win-repaint pager win))))

  (define (while-moving-eye pager window)
    (let*
        ((frame (sawlet-frame pager))
         (pos (cons- (query-pointer) (cons- (window-position frame) (window-frame-offset frame)))))
      (when (and-cons (cons-and (cons>= pos 0) (cons< pos (window-dimensions frame))))
        (let*
            ((repos (cons- (cons* pos (sawlet-config pager 'divisor)) move-window-initial-pointer-offset (viewport-offset))))
          (setq move-window-unconstrained t
            move-resize-x (car repos) move-resize-y (cdr repos))))))

  (define (after-move-eye pager window directions)
    (sawlet-put pager 'drag-win nil))

  ;;;;

  (define (viewport-repaint pager)
    (x-clear-window (sawlet-get pager 'viewport)))

  (define (viewport-event-handler type window event)
    (let ((sawlet (x-window-get window 'sawlet)))
      (cond ((eq type 'expose) (viewport-repaint pager))
	    ((eq type 'enter-notify) (window-enter-notify-handler pager event)))))

  (define pagers nil)

  (mapc
    (lambda (hook)
      (add-hook (car hook)
        (lambda (#!rest args)
          (mapc
            (lambda (pager)
              (apply (cdr hook) (list* pager args)))
            pagers))))
    `((window-moved-hook . ,window-moved-eye)
      (window-resized-hook . ,window-moved-eye)
      (window-maximized-hook . ,window-moved-eye)
      (window-unmaximized-hook . ,window-moved-eye)
      (place-window-hook . ,after-add-window-eye) ;; hack
      (after-add-window-hook . ,after-add-window-eye) ;; hack
      (after-restacking-hook . ,after-restacking-eye)
      (map-notify-hook . ,map-notify-eye)
      (unmap-notify-hook . ,map-notify-eye) ;; destroy-notify-hook??
      (iconify-window-hook . ,map-notify-eye)
      (uniconify-window-hook . ,map-notify-eye)
      (add-to-workspace-hook . ,map-notify-eye)
      (remove-from-workspace-hook . ,map-notify-eye)
      (enter-workspace-hook . ,enter-workspace-eye)
      (viewport-moved-hook . ,viewport-moved-eye)
      (viewport-resized-hook . ,viewport-resized-eye)
      (focus-in-hook . ,focus-in-eye)
      (focus-out-hook . ,focus-out-eye)
      (property-notify-hook . ,property-notify-eye)
      (while-moving-hook . ,while-moving-eye)
      (after-move-hook . ,after-move-eye)))

  (define (start pager)
    (let
        ((viewport
           (x-create-window
            (viewport-position pager)
            (viewport-dimensionz pager)
            (car (sawlet-config pager 'viewport-border))
            `((parent . ,(sawlet-get pager 'window))
              (background . ,(sawlet-config pager 'viewport-background))
              (border-color . ,(cdr (sawlet-config pager 'viewport-border)))
              (override-redirect . t)
              (event-mask . (exposure enter-window)))
            viewport-event-handler)))
      (x-window-put viewport 'sawlet pager)
      (sawlet-put pager 'viewport viewport x-destroy-window)
      (x-x-map-window viewport))
    (mapc
      (lambda (window)
        (after-add-window-eye pager window))
      (reverse (stacking-order)))
    (setq pagers (nconc pagers (list pager))))

  (define (stop pager)
    (setq pagers (delq pager pagers))
    (mapc
      (lambda (window)
        (let
            ((win (window-get window (sawlet-symbol pager 'win))))
          (when win
            (window-put window (sawlet-symbol pager 'win) nil)
            (x-destroy-window win))))
      (managed-windows))
    (sawlet-put pager 'viewport nil x-destroy-window))

  (define (post-configure pager)
    (let
	((viewport (sawlet-get pager 'viewport))
         (pos (viewport-position pager))
	 (dim (viewport-dimensionz pager)))
      (x-configure-window
       viewport
       `((x . ,(car pos))
	 (y . ,(cdr pos))
	 (width . ,(car dim))
	 (height . ,(cdr dim))
	 (border-width . ,(car (sawlet-config pager 'viewport-border)))))
      (x-change-window-attributes
       viewport
       `((background . ,(sawlet-config pager 'viewport-background))
	 (border-color . ,(cdr (sawlet-config pager 'viewport-border)))))
      (viewport-repaint pager))
    (mapc
      (lambda (window)
        (let
            ((win (window-get window (sawlet-symbol pager 'win))))
          (when win
            (win-reconfigure pager win))))
      (managed-windows)))

  (define (window-expose-handler pager event)
    (x-clear-window (cdr (assq 'window event))))

  (define (window-enter-notify-handler pager event)
    (let
        ((frame (sawlet-frame pager)))
      (unless (sawlet-get pager 'drag-win)
        (call-hook 'enter-notify-hook (list frame 'normal)))))

  (define (window-button-press-handler pager event)
    (let*
	((button (cdr (assq 'button event)))
         (x (cdr (assq 'x event)))
         (y (cdr (assq 'y event)))
         (viewport (cons-quotient
                     (cons* (cons x y) (sawlet-config pager 'divisor))
                     (screen-dimensions))))
      (when (eq button 'button-1)
        (set-screen-viewport (car viewport) (cdr viewport)))))

  ;; a hack on sawfish.wm.viewport#set-viewport so I can ignore the myriand
  ;; move-windows...

  (eval-in
   `(let
       ((old-set-viewport set-viewport))
     (define (set-viewport x y)
       (setq viewport-xy (cons x y))
       (old-set-viewport x y)))
   'sawfish.wm.viewport)

   (defmacro defpager (pager . keys)
    `(progn
      (require 'merlin.sawlet)
      ,(append
        `(defsawlet ,pager)
        keys ; allow override
        `(:start ,start
        :stop ,stop
        :post-configure ,post-configure
        :dimensions ,dimensions
        :expose-handler ,window-expose-handler
        :enter-notify-handler ,window-enter-notify-handler
        :button-press-handler ,window-button-press-handler
        :font ,nil        
        :foreground ,nil
        :background (get-color-rgb 0 0 0)
        :defcustom (viewport-background (get-color-rgb 0 8192 0)
          "Viewport background color."
          :type color
          :after-set sawlet-reconfigure)
        :defcustom (viewport-border (cons 1 (get-color-rgb 0 16384 0))
          "Viewport internal border."
          :type (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color))
          :after-set sawlet-reconfigure)
        :defcustom (divisor (cons 24 24)
          "Divisor from screen to pager."
          :type (pair (labelled "Horizontal:" (number 2 100)) (labelled "Vertical:" (number 2 100)))
          :after-set sawlet-reconfigure)
        :defgroup (windows "Windows")
        :defcustom (win-font (get-font "-misc-fixed-*-*-*-*-7-*-*-*-*-*-*-*")
          "Window font."
          :type font
          :group (windows)
          :after-set sawlet-reconfigure)
        :defcustom (win-color (cons (get-color-rgb 36864 24576 0) (get-color-rgb 16384 0 0))
          "Window color."
          :type (pair (labelled "Foreground:" color) (labelled "Background:" color))
          :group (windows)
          :after-set sawlet-reconfigure)
        :defcustom (win-border (cons 1 (get-color-rgb 24576 0 0))
          "Window border."
          :type (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color))
          :group (windows)
          :after-set sawlet-reconfigure)
        :defcustom (focused-win-font (get-font "-misc-fixed-*-*-*-*-7-*-*-*-*-*-*-*")
          "Focused window font."
          :type font
          :group (windows)
          :after-set sawlet-reconfigure)
        :defcustom (focused-win-color (cons (get-color-rgb 65535 65535 0) (get-color-rgb 28672 0 0))
          "Focused window color."
          :type (pair (labelled "Foreground:" color) (labelled "Background:" color))
          :group (windows)
          :after-set sawlet-reconfigure)
        :defcustom (focused-win-border (cons 1 (get-color-rgb 36864 0 0))
          "Focused window border."
          :type (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color))
          :group (windows)
          :after-set sawlet-reconfigure))))))
