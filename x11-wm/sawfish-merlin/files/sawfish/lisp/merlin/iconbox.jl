;; merlin/iconbox.jl -- a bad icon manager

;; version -0.98

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
;;   mv iconbox.jl ~/.sawfish/lisp/merlin

;; You also need merlin/sawlet.jl, merlin/util.jl and merlin/x-util.jl.

;; You're probably best off unpacking the entire merlin.tgz archive.

;; Then add to your .sawfishrc:
;;   (require 'merlin.iconbox)
;;   (deficonbox iconbox)

;; Then restart sawfish. An icon box should appear in the top right corner
;; of your screen.

;; Go to Customize->Sawlets->Iconbox
;;   - Here you can customize the behaviour of the icon box 
;; Also go to Customize->Matched Windows->^Sawlet/iconbox$->Edit...
;;   - Here you can specify a border type for the window, etc.

;; You can create multiple icon boxes and can configure them programatically
;; at creation if you want.. but you probably don't..

;;;;;;;;;;;;;;;;;;
;; HERE BE BUGS ;;
;;;;;;;;;;;;;;;;;;

;; TODO: Orientation, ... hover delay ..., tooltips, ... use icon name

;; TODO: only display windows iconified on current viewport/workspace.

;; TODO: support dragging into iconbox?

; BUG: I don't understand why, but if you click then drag a fraction
; (preferably, but not necessarily to outside of the icon) then wait
; a while then containue the drag, nothing happens. but if you
; only wait a short while before continuing then it works.
; I don't get the events??

; Events are lost. But it is not me (I think).

;;;;

(define-structure merlin.iconbox

  (export
   deficonbox)

  (open
   rep
   rep.system
   rep.io.timers
   sawfish.wm.colors
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

  ;;;;

  (define (schedule iconbox window)
    (sawlet-put iconbox 'hover-pending window)
    (if (eq window (sawlet-get iconbox 'hover-window))
        (sawlet-put iconbox 'hover-timer nil delete-timer)
      (sawlet-put iconbox 'hover-timer
        (make-timer (lambda () (timeout iconbox)) 0 333) delete-timer)))

  (define (timeout iconbox)
    (let ((hover (sawlet-get iconbox 'hover-window))
          (pending (sawlet-get iconbox 'hover-pending)))
      (when hover
        (when (equal (sawlet-get iconbox 'hover-new-position)
                     (window-position hover))
          (move-window-to hover (sawlet-get iconbox 'hover-old-x)
                                (sawlet-get iconbox 'hover-old-y)))
        (restack-windows (sawlet-get iconbox 'hover-stacking)) ;; TODO: only really want to replace hover
        (hide-window hover))
      (when (sawlet-put iconbox 'hover-window pending)
        (sawlet-put iconbox 'hover-pending nil)
        (sawlet-put iconbox 'hover-stacking (stacking-order))
        (let ((pos (window-position pending)))
          (sawlet-put iconbox 'hover-old-x (car pos))
          (sawlet-put iconbox 'hover-old-y (cdr pos)))
        (show-window pending)
        (raise-window pending)
        (when (window-outside-viewport-p pending)
          (move-window-to-current-viewport pending))
        (sawlet-put iconbox 'hover-new-position (window-position pending))
        (call-hook 'enter-notify-hook (list pending 'normal)))))
    
  ;;;;

  (define (dimensions iconbox)
    (let*
        ((columns (sawlet-config iconbox 'icon-columns)))
      (cons (* columns (sawlet-config iconbox 'icon-width))
        (if (sawlet-config iconbox 'fixed-height)
            (sawlet-config iconbox 'height)
          (* (max 1 (ceil (length (sawlet-get iconbox 'icons)) columns))
            (+ (font-height (sawlet-config iconbox 'icon-font))
              (* 2 (car (sawlet-config iconbox 'icon-border)))))))))

  (define (icon-foo iconbox icon foo)
    (sawlet-config iconbox
      (if (eq icon (sawlet-get iconbox 'focused-icon))
          (intern (format nil "focused-%s" foo))
        foo)))

  (define (icon-position iconbox icon)
    (let
        ((columns (sawlet-config iconbox 'icon-columns))
         (index (index-of icon (sawlet-get iconbox 'icons))))
      (cons (* (% index columns) (sawlet-config iconbox 'icon-width))
        (* (quotient index columns)
          (+ (font-height (sawlet-config iconbox 'icon-font))
            (* 2 (car (sawlet-config iconbox 'icon-border))))))))

  (define (icon-dimensions iconbox icon) ; ? use max heights ?
    (cons- (cons (sawlet-config iconbox 'icon-width)
      (+ (font-height (sawlet-config iconbox 'icon-font))
        (* 2 (car (sawlet-config iconbox 'icon-border)))))
      (* 2 (car (icon-foo iconbox icon 'icon-border)))))

  (define (icon-reconfigure iconbox icon)
    (let*
        ((pos (icon-position iconbox icon))
         (dim (icon-dimensions iconbox icon))
         (border (icon-foo iconbox icon 'icon-border)))
      (x-configure-window
        icon
        `((x . ,(car pos))
          (y . ,(cdr pos))
          (width . ,(car dim))
          (height . ,(cdr dim))
          (border-width . ,(car border))))
      (x-change-window-attributes
        icon
        `((background . ,(cdr (icon-foo iconbox icon 'icon-color)))
          (border-color . ,(cdr border))))
      (icon-repaint iconbox icon)))

  (define (icon-repaint iconbox icon)
    (let*
	((window (x-window-get icon 'window))
         (gc (sawlet-get iconbox 'gc))
	 (title (window-name window))
	 (font (icon-foo iconbox icon 'icon-font)))
      (x-clear-window icon)
      (x-change-gc gc `((foreground . ,(car (icon-foo iconbox icon 'icon-color)))))
      (x-draw-string icon gc (cons 1 (font-ascent font)) title font)))

  (define (icon-button-press-handler iconbox event)
    (let*
	((icon (cdr (assq 'window event)))
	 (window (x-window-get icon 'window))
         (xy (cons (cdr (assq 'x event)) (cdr (assq 'y event))))
	 (button (cdr (assq 'button event))))
      (cond
       ((eq button 'button-1)
        (sawlet-put iconbox 'click-xy xy)
        (sawlet-put iconbox 'click-window window))
       ((eq button 'button-3)
        (current-event-window window)
	(popup-window-menu window)))))

  (define (icon-motion-notify-handler iconbox event)
    (let*
        ((icon (cdr (assq 'window event)))
         (xy (cons (cdr (assq 'x event)) (cdr (assq 'y event))))
         (oxy (or (sawlet-get 'iconbox 'click-xy) xy))
         (delta (cons- xy oxy))
         (bd (car (icon-foo iconbox icon 'icon-border)))
         (nxy (cons- (query-pointer) oxy bd)))
      (when (> (+cons (cons* delta delta)) 36)
        (sawlet-put iconbox 'click-window nil
          (lambda (w)
            (when (eq w (sawlet-get iconbox 'hover-window))
              (sawlet-put iconbox 'hover-window nil))
            (when (eq w (sawlet-get iconbox 'hover-pending))
              (sawlet-put iconbox 'hover-pending nil)
              (sawlet-put iconbox 'hover-timer nil delete-timer))
            (unless (window-appears-in-workspace-p w current-workspace)
              (move-window-to-workspace w
                (nearest-workspace-with-window w current-workspace)
                current-workspace))
            (move-window-to w (car nxy) (cdr nxy))
            (uniconify-window w)
            (setq move-window-initial-pointer-offset (cons+ oxy bd))
            (move-window-interactively w))))))

  (define (icon-button-release-handler iconbox event)
    (let*
	((button (cdr (assq 'button event))))
      (cond
        ((eq button 'button-1)
         (sawlet-put iconbox 'click-window nil display-window)))))

  (define (icon-enter-notify-handler iconbox event)
    (let*
	((icon (cdr (assq 'window event)))
	 (window (x-window-get icon 'window)))
      (sawlet-put iconbox 'focused-icon icon)
      (icon-reconfigure iconbox icon)
      (when (sawlet-config iconbox 'hover-show)
        (schedule iconbox window)
        (when (eq window (sawlet-get iconbox 'hover-window))
          (call-hook 'enter-notify-hook (list window 'normal))))))

  (define (icon-leave-notify-handler iconbox event)
    (let*
	((icon (cdr (assq 'window event)))
	 (window (x-window-get icon 'window)))
      (sawlet-put iconbox 'focused-icon nil)
      (icon-reconfigure iconbox icon)
      (schedule iconbox nil)
      (when (eq window (sawlet-get iconbox 'hover-window))
        (call-hook 'leave-notify-hook (list window 'normal)))))

  (define (icon-expose-handler iconbox event)
    (icon-repaint iconbox (cdr (assq 'window event))))

  (define icon-event-handlers
    `((button-press . ,icon-button-press-handler)
      (motion-notify . ,icon-motion-notify-handler)
      (button-release . ,icon-button-release-handler)
      (enter-notify . ,icon-enter-notify-handler)
      (leave-notify . ,icon-leave-notify-handler)
      (expose . ,icon-expose-handler)))

  (define (icon-event-handler type window event)
    (let
        ((handler (assq type icon-event-handlers)))
      (when handler
        ((cdr handler) (x-window-get window 'sawlet) event))))

  ;;;;

  (define (after-add-window-eye iconbox window)
    (when (window-get window 'iconified)
      (iconify-window-eye iconbox window)))

  (define (iconify-window-eye iconbox window)
    (unless (not (window-mapped-p window))
      (let*
	  ((icon (x-create-window
                   (cons 1024 1024)
                   (cons 16 16)
                   0
                   `((parent . ,(sawlet-get iconbox 'window))
                     (override-redirect . t)
                     (event-mask . (button-press button-motion button-release
                                    enter-window leave-window exposure)))
                   icon-event-handler)))
        (x-window-put icon 'sawlet iconbox)
        (x-window-put icon 'window window)
	(window-put window (sawlet-symbol iconbox 'icon) icon)
	(sawlet-put iconbox 'icons (nconc (sawlet-get iconbox 'icons) (list icon)))
	(x-x-map-window icon)
	(sawlet-reconfigure iconbox))))

  (define (uniconify-window-eye iconbox window)
    (when (or (eq window (sawlet-get iconbox 'hover-window))
              (eq window (sawlet-get iconbox 'hover-pending)))
      (sawlet-put iconbox 'hover-timer nil delete-timer))
    (when (eq window (sawlet-get iconbox 'hover-window))
      (sawlet-put iconbox 'hover-window nil)
      (unless (or (window-get window 'sticky)
		  (window-in-workspace-p window current-workspace))
	(hide-window window))
      (unless raise-windows-on-uniconify
	(restack-windows (sawlet-get iconbox 'hover-stacking)))
      (unless uniconify-to-current-viewport ;; todo: or was moved
	(move-window-to window
          (sawlet-get iconbox 'hover-old-x)
          (sawlet-get iconbox 'hover-old-y))))
    (let*
	((icon (window-get window (sawlet-symbol iconbox 'icon))))
      (when icon
	(window-put window (sawlet-symbol iconbox 'icon) nil)
	(sawlet-put iconbox 'icons (delq icon (sawlet-get iconbox 'icons)))
	(x-destroy-window icon)
        (sawlet-reconfigure iconbox))))

  (define (hover-window-or-a-transient-p iconbox window)
    (let
        ((shown (sawlet-get iconbox 'hover-window))
         (transient (and (windowp window) (window-transient-p window))))
      (or (eq window shown) (and shown (eq transient (window-id shown))))))

  (define (enter-notify-eye iconbox window)
    (when (hover-window-or-a-transient-p iconbox window)
      (schedule iconbox window)))

  (define (leave-notify-eye iconbox window)
    (when (hover-window-or-a-transient-p iconbox window)
      (schedule iconbox nil)))

  (define (property-notify-eye iconbox window property state)
    (let*
        ((icon (window-get window (sawlet-symbol iconbox 'icon))))
      (when (and icon (eq property 'WM_NAME))
	(icon-repaint iconbox icon))))

  ;;;;

  (define iconboxes nil)

  (mapc
    (lambda (hook)
      (add-hook (car hook)
        (lambda (#!rest args)
          (mapc
            (lambda (iconbox)
              (apply (cdr hook) (list* iconbox args)))
            iconboxes))))
    `((after-add-window-hook . ,after-add-window-eye)
      (iconify-window-hook . ,iconify-window-eye)
      (uniconify-window-hook . ,uniconify-window-eye)
      (enter-notify-hook . ,enter-notify-eye)
      (leave-notify-hook . ,leave-notify-eye)
      (property-notify-hook . ,property-notify-eye)
      (unmap-notify-hook . ,uniconify-window-eye)
      (destroy-notify-hook . ,uniconify-window-eye)))

  (define (start iconbox)
    (mapc
      (lambda (window)
        (after-add-window-eye iconbox window))
      (managed-windows))
    (setq iconboxes (nconc iconboxes (list iconbox))))

  (define (stop iconbox)
    (setq iconboxes (delq iconbox iconboxes))
    (mapc
      (lambda (window)
        (uniconify-window-eye iconbox window))
      (managed-windows)))

  (define (post-configure iconbox)
    (mapc
      (lambda (icon)
        (icon-reconfigure iconbox icon))
      (sawlet-get iconbox 'icons)))

  (define (window-expose-handler iconbox event)
    (x-clear-window (cdr (assq 'window event))))

  (define (window-enter-notify-handler iconbox event)
    (let
        ((frame (sawlet-frame iconbox)))
      (call-hook 'enter-notify-hook (list frame 'normal))))

  (defmacro deficonbox (iconbox . keys)
    `(progn
      (require 'merlin.sawlet)
      ,(append
        `(defsawlet ,iconbox)
        keys ; allow override
        `(:start ,start
        :stop ,stop
        :post-configure ,post-configure
        :dimensions ,dimensions
        :expose-handler ,window-expose-handler
        :enter-notify-handler ,window-enter-notify-handler
        :font ,nil
        :foreground ,nil
        :defcustom (icon-columns 2
          "Number of icon columns."
          :type (number 1 20)
          :after-set sawlet-reconfigure)
        :defcustom (fixed-height nil
          "Fixed height."
          :type boolean
          :after-set sawlet-reconfigure)
        :defcustom (height 64
          "Height."
          :type (number 1 1024)
          :depends fixed-height
          :after-set sawlet-reconfigure)
        :defcustom (hover-show t
          "Temporarily show iconified windows on mouse hover."
          :type boolean)
        :defgroup (icons "Icons")
        :defcustom (icon-width 48
          "Icon width."
          :type (number 1 256)
          :group (icons)
          :after-set sawlet-reconfigure)
        :defcustom (icon-font (get-font "-misc-fixed-*-*-*-*-7-*-*-*-*-*-*-*")
          "Icon font."
          :type font
          :group (icons)
          :after-set sawlet-reconfigure)
        :defcustom (icon-color (cons (get-color-rgb 40960 40960 40960) (get-color-rgb 16384 0 0))
          "Icon color."
          :type (pair (labelled "Foreground:" color) (labelled "Background:" color))
          :group (icons)
          :after-set sawlet-reconfigure)
        :defcustom (icon-border (cons 1 (get-color-rgb 24576 0 0))
          "Icon border."
          :type (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color))
          :group (icons)
          :after-set sawlet-reconfigure)
        :defcustom (focused-icon-font (get-font "-misc-fixed-*-*-*-*-7-*-*-*-*-*-*-*")
          "Focused icon font."
          :type font
          :group (icons)
          :after-set sawlet-reconfigure)
        :defcustom (focused-icon-color (cons (get-color-rgb 65535 65535 65535) (get-color-rgb 28672 0 0))
          "Focused icon color."
          :type (pair (labelled "Foreground:" color) (labelled "Background:" color))
          :group (icons)
          :after-set sawlet-reconfigure)
        :defcustom (focused-icon-border (cons 1 (get-color-rgb 36864 0 0))
          "Focused icon border."
          :type (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color))
          :group (icons)
          :after-set sawlet-reconfigure))))))
