;; merlin/icons.jl -- another bad icon manager

;; version -0.5.1

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

;                                    ;
;                           #        ;
;                           #        ;
;                      ######        ;
;                 ###########        ;
;             ##########             ;
;        ##########                  ;
;          ####                      ;
;              ####                  ;
;           ##########               ;
;       ##########                   ;
;            ####                    ; This Software is Not Good Software.
;                 ###                ; 
;                     ####  #        ; The Tao of Sawfish is that
;                          ##        ; a Window Manager Manages Windows.
;                           #        ;
;       #                            ; That is How It Should Be. 
;       #                            ;
;       # ###                        ; That is Right.
;             ###                    ; 
;              #  ###                ; This Software violates the Tao of
;              #      ###            ; Sawfish by making the window manager
;              #      #######        ; do what it should not.
;              #  #########          ;
;             ########               ; The Purity of Sawfish is Sullied by
;       # #########                  ; this Software.
;       ######                       ;
;       ###                          ; This Software Should Not Be.
;       #                            ;
;       #                   #        ; Do not use this Software.
;       #####################        ;
;       #####################        ; Merely observe, weep, gnash of your
;       #          ##       #        ; teeth and pull of your hair.
;               #####       #        ;
;            ########       #        ; --
;       # #######   #       #        ;
;       ######      ##     ##        ; Use instead a real icon manager
;       ###          #######         ; based on stph or somesuch.
;       #              ###           ;
;       #                   #        ; --
;       #####################        ;
;       #                 ###        ; Let me reiterate one more time
;                      ######        ; before I'm drunk again:
;                   #######          ;
;                #######             ; This software is a retrograde step.
;             #######                ;
;           #######                  ; The Purity And Lightness of Sawfish
;        ######             #        ; is its Greatness.
;       #####################        ;
;                                    ; A Window Manager should not include
;       #                   #        ; Applications such as this.
;       #####################        ;
;       #####################        ; Discrete applications can do a much
;       #                   #        ; better job.
;                                    ;
;       #                   #        ; This Software is a return to the old
;       #####################        ; ways of proprietary gadgets on
;       #                 ###        ; bloated, unstable window managers.
;                      ######        ;
;                   #######          ; --
;                #######             ;
;             #######                ; For the love of all that is good,
;           #######                  ; turn back now.
;        ######             #        ;
;       #####################        ;
;                                    ;
;               #####                ;
;           #############            ;
;         #################          ;
;        ###              ##         ;
;        #                  #        ;
;       #                   #        ;
;        #                  #        ;
;        ##               ##         ;
;         #########      ####        ;
;            ######                  ;
;                 #                  ;
;                                    ;

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
;;   mv icons.jl ~/.sawfish/lisp/merlin

;; You also need merlin/util.jl, merlin/x-util.jl and merlin/uglicon.jl.

;; Then add to your .sawfishrc:
;;   (require 'merlin.icons.)

;; Then restart sawfish. Iconified windows should now get little icons.

;; Go to Customize->Icons
;;      - Here you can customize the behaviour of the icons. 
;; Go to Customize->Icons->Icon keymap
;;      - Here you can configure the keymap that is active for icons.
;;      - By default, mouse-1 moves the window, double-clicking mouse-1
;;        uniconifies it and mouse 3 brings up the window menu.
;;      - In particular you will want to use the "Icon window commands"
;;        command, which applies a sequence of commands to the iconified
;;        window (as opposed to the icon itself).
;; Go to Customize->Icons->Icon matchers
;;      - Here you can configure matched properties for the icons; for
;;        example, you can force them all to a low depth or to use a
;;        special icon placement mode. You might want to look at
;;        merlin.sawlet-placement for an appropriate placement mode.
;;      - Icons inherit the name of their parent, so if you want to
;;        customize the icons of particular windows you can, to a
;;        certain extent.

;;;;;;;;;;;;;;;;;;
;; HERE BE BUGS ;;
;;;;;;;;;;;;;;;;;;

;; TODO: can I share a gc?

;; TODO: does this cope at all well with multiple workspaces?
;; I guess I should inherit workspaces from a parent... and
;; keep up with changes thereto.

;;;;

(define-structure merlin.icons

  (export
   icons-start
   icons-stop)

  (open
   rep
   rep.system
   rep.io.timers
   sawfish.wm.colors
   sawfish.wm.commands
   sawfish.wm.custom
   sawfish.wm.events
   sawfish.wm.fonts
   sawfish.wm.frames
   sawfish.wm.images
   sawfish.wm.keymaps
   sawfish.wm.menus
   sawfish.wm.misc
   sawfish.wm.placement
   sawfish.wm.stacking
   sawfish.wm.windows
   sawfish.wm.ext.match-window
   sawfish.wm.ext.tooltips
   sawfish.wm.state.iconify
   sawfish.wm.util.decode-events
   sawfish.wm.util.keymap
   sawfish.wm.util.x
   merlin.uglicon
   merlin.util
   merlin.x-util)

  (defgroup icons "Icons")

  (defgroup icons-keymap "Icon keymap" :group icons :layout single)

  (defgroup icons-matchers "Icon matchers" :group icons :layout single :require sawfish.wm.ext.match-window)

  (defcustom icons-enabled t
    "Enable icons for iconified windows."
    :type boolean
    :group (icons)
    :after-set (lambda () (icons-go)))

  (defcustom icons-tooltips t
    "Show iconified window titles using tooltips."
    :type boolean
    :group (icons))

  (defcustom icons-background (get-color-rgb 65535 65535 65535)
    "Icon background color."
    :type color
    :group (icons)
    :after-set (lambda () (icons-reconfigure)))

  (defcustom icons-show-text t
    "Show icon names."
    :type boolean
    :group (icons)
    :after-set (lambda () (icons-reconfigure)))

  (defcustom icons-text-from 'window-name
    "Source of icon name."
    :type (choice window-name window-icon-name)
    :group (icons)
    :depends icons-show-text
    :after-set (lambda () (icons-reconfigure)))

  (defcustom icons-text (cons (get-color-rgb 0 0 0) (get-font "-misc-fixed-*-*-*-*-7-*-*-*-*-*-*-*"))
    "Appearance of icon names."
    :type (pair (labelled "Color:" color) (labelled "Font:" font))
    :group (icons)
    :depends icons-show-text
    :after-set (lambda () (icons-reconfigure)))

  (defcustom icons-padding (cons 8 8)
    "Padding around icon."
    :type (pair (labelled "Horizontal:" (number 0 100)) (labelled "Vertical:" (number 0 100)))
    :group (icons)
    :after-set (lambda () (icons-reconfigure)))

  (defcustom icons-border (cons 1 (get-color-rgb 65535 0 0))
    "Internal border around icon."
    :type (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color))
    :group (icons)
    :after-set (lambda () (icons-reconfigure)))

  (defcustom icons-keymap (make-keymap)
    ""
    :group (icons icons-keymap)
    :user-level expert
    :type keymap)

  (defcustom icons-match-profile
    `((((WM_CLASS . "icon/Merlin"))
       (cycle-skip . t)
       (window-list-skip . t)
       (skip-tasklist . t)
       (never-iconify . t)
       (frame-type . border-only)
       (place-mode . none)))
    nil
    :group (icons icons-matchers)
    :type match-window)

  ;;;;

  (define (icons-get-icon w)
    (let
        ((icon (window-get w 'merlin.icon)))
      (and icon (get-window-by-id (x-window-id icon)))))

  (define (icons-get-icon-window w) ;; oh so inefficient, want get-x-window-by-id
    (let
        ((id (window-id w)))
      (catch 'out
        (mapc (lambda (w)
          (let
              ((icon (window-get w 'merlin.icon)))
            (when (and icon (eq id (x-window-id icon)))
              (throw 'out w)))) (managed-windows))
        nil)))

  (define (icons-get-text w)
    (let
        ((text ((if (eq icons-text-from 'window-name) window-name window-icon-name) w))
         (width (+ uglicon-width (* 2 (car icons-padding)))))
      (trim text (cdr icons-text) width)))

  ;;;;

  (define (icon-reconfigure w)
    (let*
	((window (window-get w 'merlin.icon))
	 (background (x-window-get window 'background))
	 (gc (x-window-get window 'gc))
	 (bg-dim (cons+ (cons uglicon-width (+ uglicon-height (if icons-show-text (font-height (cdr icons-text)) 0))) (cons* icons-padding 2)))
	 (win-dim (cons+ bg-dim (* 2 (car icons-border))))
	 (caption (icons-get-text w)))
      (x-set-wm-size-hints window win-dim win-dim)
      (x-window-put window 'caption caption)
      (x-change-gc gc
        `((foreground . ,(car icons-text))))
      ((x-configure-fn) window
        `((width . ,(car win-dim))
	  (height . ,(cdr win-dim))))
      (x-change-window-attributes background
        `((background . ,icons-background)
	  (border-color . ,(cdr icons-border))))
      (x-configure-window background
        `((width . ,(car bg-dim))
          (height . ,(cdr bg-dim))
	  (border-width . ,(car icons-border))))
      (icons-repaint w))) ;; could reapply the match-window settings

  (define (icons-reconfigure)
    (mapc (lambda (w)
             (when (window-get w 'merlin.icon)
	       (icon-reconfigure w))) (managed-windows)))

  ;;;;

  (define (icons-repaint w)
    (let*
	((window (window-get w 'merlin.icon))
	 (background (x-window-get window 'background))
	 (gc (x-window-get window 'gc))
	 (icon (x-window-get window 'icon))
	 (icon-pos (cons+ (cons-quotient (cons- (cons uglicon-width uglicon-height) (image-dimensions icon)) 2) icons-padding)))
      (x-clear-window background)
      (x-draw-image icon background icon-pos)
      (when icons-show-text
        (let*
            ((caption (x-window-get window 'caption))
             (caption-pos (cons (quotient (- (+ uglicon-width (* 2 (car icons-padding))) (text-width caption (cdr icons-text))) 2) (+ uglicon-height (cdr icons-padding) (- (font-height (cdr icons-text)) (font-descent (cdr icons-text)))))))
          (x-draw-string background gc caption-pos caption (cdr icons-text))))))

  ;;;;

  (define (icons-event-expose event)
    (let*
	((window (cdr (assq 'window event)))
	 (w (x-window-get window 'parent)))
      (icons-repaint w)))

  (define (icons-event-enter-notify event)
    (let*
	((window (cdr (assq 'window event)))
	 (w (x-window-get window 'parent)))
      (when icons-tooltips
        (let ((tooltips-enabled t))
          (display-tooltip-after-delay (window-name w) (icons-get-icon w))))))

  (define (icons-event-leave-notify event)
    (let*
	((window (cdr (assq 'window event)))
	 (w (x-window-get window 'parent)))
      (when icons-tooltips
        (remove-tooltip))))

  (define (icons-event-client-message event)
    (let*
        ((window (cdr (assq 'window event)))
         (message-type (cdr (assq 'message-type event)))
         (format (cdr (assq 'format event)))
         (data (cdr (assq 'data event)))
         (w (x-window-get window 'parent)))
      (when (and (eq message-type 'WM_PROTOCOLS)
		 (eq format 32)
		 (eq (aref data 0) (x-atom 'WM_DELETE_WINDOW)))
	(uniconify-window w)))) ;; or do I just delete the icon?

  (define (icons-event-handler type win event)
    (cond ((eq type 'expose) (icons-event-expose event))
	  ((eq type 'enter-notify) (icons-event-enter-notify event))
	  ((eq type 'leave-notify) (icons-event-leave-notify event))
          ((eq type 'client-message) (icons-event-client-message event))))

  ;;;;

  (define (icons-hook-iconify-window w)
    (unless (window-get w 'merlin.icon)
      (let*
          ((win-pos (or (window-get w 'merlin.icon.position) (window-position w)))
	   (bg-dim (cons+ (cons uglicon-width (+ uglicon-height (if icons-show-text (font-height (cdr icons-text)) 0))) (cons* icons-padding 2)))
	   (win-dim (cons+ bg-dim (* 2 (car icons-border))))
	   (caption (icons-get-text w))
	   (icon (get-window-icon w))
	   (window (x-create-window
	     win-pos
	     win-dim
	     0
	     `((override-redirect . ,nil)
	       (event-mask . ,'()))
	     icons-event-handler))
	   (background (x-create-window
	     (cons 0 0)
	     bg-dim
	     (car icons-border)
	     `((parent . ,window)
	       (background . ,icons-background)
	       (border-color . ,(cdr icons-border))
	       (override-redirect . ,t)
	       (event-mask . ,'(exposure enter-window leave-window)))
	     icons-event-handler))
	   (gc (x-create-gc
	     window
	     `((foreground . ,(car icons-text))))))
        (x-set-wm-name window (window-name w))
        (x-set-wm-icon-name window (window-icon-name w))
	(x-set-wm-class window "Merlin" "icon")
        (x-set-wm-protocols window '(delete-window))
        (x-set-wm-size-hints window win-dim win-dim)
	(x-window-put background 'parent w)
	(x-window-put window 'parent w)
	(x-window-put window 'background background)
	(x-window-put window 'gc gc)
	(x-window-put window 'icon icon)
	(x-window-put window 'caption caption)
	(x-window-put window 'merlin.icons.is-icon t)
	(window-put w 'merlin.icon window)
	((x-map-fn) window)
	(x-x-map-window background)
        (icons-repaint w))))

  (define (icons-hook-uniconify-window w)
    (when (window-get w 'merlin.icon)
      (let*
          ((window (window-get w 'merlin.icon))
	   (background (x-window-get window 'background))
	   (gc (x-window-get window 'gc))
           (icon (get-window-by-id (x-window-id window))))
	(window-put w 'merlin.icon.position (window-position icon))
	(window-put w 'merlin.icon nil)
	(x-free-gc gc)
	(x-destroy-window background)
	(x-destroy-window window))))

  (define (icons-hook-after-add-window w)
    (when (window-get w 'iconified)
      (icons-hook-iconify-window w)))

  (define (icons-hook-before-add-window w)
    (let*
        ((parent (icons-get-icon-window w))
         (match-window-profile icons-match-profile))
      (when parent ; it is an icon window
        (match-window w)
        (window-put w 'parent parent)
        (window-put w 'keymap icons-keymap)
        (when (window-get parent 'sticky)
         (window-put w 'sticky t))
        (when (window-get parent 'sticky-viewport)
         (window-put w 'sticky-viewport t))))) ; should I note the change?

  (define (icons-hook-unmap-notify w)
    (icons-hook-uniconify-window w))

  (define (icons-hook-destroy-notify w)
    (icons-hook-uniconify-window w))

  (define (icons-hook-property-notify w property state)
    (when (eq property (if (eq icons-text-from 'window-name) 'WM_NAME 'WM_ICON_NAME))
      (when (and icons-show-text (window-get w 'merlin.icon))
        (icon-reconfigure w)))) ;; a bit brutal

  ;; sawfish doesn't really differentiate sticky and sticky-viewport
  ;; at this level.
  (define (window-state-change-eye w state)
    (let*
        ((icon (icons-get-icon w)))
      (when (and icon (memq 'sticky state))
        (if (window-sticky-p w)
            (make-window-sticky icon)
          (make-window-unsticky icon)))))

  ;;;;

  (define icons-hooks
    `((iconify-window-hook . ,icons-hook-iconify-window)
      (uniconify-window-hook . ,icons-hook-uniconify-window)
      (before-add-window-hook . ,icons-hook-before-add-window)
      (after-add-window-hook . ,icons-hook-after-add-window)
      (unmap-notify-hook . ,icons-hook-unmap-notify)
      (destroy-notify-hook . ,icons-hook-destroy-notify)
      (property-notify-hook . ,icons-hook-property-notify)
      (window-state-change-hook . ,window-state-change-eye)))

  (define (icons-add-hooks)
    (mapc (lambda (hookfun)
	    (unless (in-hook-p (car hookfun) (cdr hookfun))
	      (add-hook (car hookfun) (cdr hookfun)))) icons-hooks))

  (define (icons-remove-hooks)
    (mapc (lambda (hookfun)
	    (when (in-hook-p (car hookfun) (cdr hookfun))
	      (remove-hook (car hookfun) (cdr hookfun)))) icons-hooks))

  (define (icons-start)
    (icons-stop)
    (mapc icons-hook-after-add-window (managed-windows))
    (icons-add-hooks))

  (define (icons-stop)
    (icons-remove-hooks)
    (mapc icons-hook-uniconify-window (managed-windows)))

  (define (icons-go)
    ((if icons-enabled icons-start icons-stop)))

  ;;;; commands

  (define (icon-window-commands commands)
    "Invoke commands on an icon's parent window."
    (let*
        ((icon (current-event-window))
         (parent (and icon (icons-get-icon-window icon))))
      (unless parent
        (error "icon-window-commands invoked on non icon window: %s" icon))
      (current-event-window parent)
      (mapc call-command commands)))

  (define-command 'icon-window-commands icon-window-commands
    #:type `(and (quoted (list command ,(_ "Command")))))

  ;;;; initialization

  ;; TODO: how do I get the behaviour that these are only defaults???

  (define (bind-key-unless key)
    (unless (search-keymap (cdr key) icons-keymap)
      (bind-keys icons-keymap (cdr key) (car key))))

  (let
      ((default-keymap (make-keymap)))
    (bind-keys default-keymap
      "Button1-Move" 'move-window-interactively
      "Button1-Click2" `(icon-window-commands '(uniconify-window))
      "Button3-Click1" `(icon-window-commands '(popup-window-menu)))
    (map-keymap bind-key-unless default-keymap)
    (map-keymap bind-key-unless window-keymap))

  (icons-go))
