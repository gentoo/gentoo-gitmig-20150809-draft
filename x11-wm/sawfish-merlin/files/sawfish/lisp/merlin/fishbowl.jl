;; merlin/fishbowl.jl -- a bad fishbowl

;; version -0.4.2

;; Copyright (C) 2000 merlin <merlin@merlin.org>

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
;;   mv fishbowl.jl ~/.sawfish/lisp/merlin

;; You also need merlin/sawlet.jl, merlin/util.jl and merlin/x-util.jl.

;; You're probably best off unpacking the entire merlin.tgz archive.

;; Then add to your .sawfishrc:
;;   (require 'merlin.fishbowl)
;;   (deffishbowl fishbowl)

;; Then restart sawfish. A fishbowl should appear in the top right corner
;; of your screen (or wherever you have configured your sawlets).

;; Go to Customize->Sawlets->Fishpond
;;      - Here you can customize the behaviour of the fishbowl. In particuar,
;;        use Shrinkage to configure that the the fishbowl should treat
;;        fish as being smaller than they claim to be. This is useful
;;        because most dockapps have transparent border space.

;; Next, go to Customize->Matched Windows
;;      - Here you must add a matched window setting for any fish that you
;;        want captured to have Place mode fishbowl. You can also set
;;        Placement weight to assert an order on the fish in the bolw;
;;        currently they are ordered left-to-right, least weight first.

;; Now, restart your apps. Hopefully they'll swim in the fishbowl.

;; You can create multiple fishbowls and can configure them programatically
;; at creation if you want..

;;;;;;;;;;;;;;;;;;
;; HERE BE BUGS ;;
;;;;;;;;;;;;;;;;;;

;; This is PRE-ALPHA INCOMPLETE SOFTWARE!

;; this is a bit hacky!

;; allow left/right/up/down placement, N columns/rows.

;; I don't restore fish border width.

;; the popup fishbowl window capture item seems to always capture
;; into 'fishbowl, not subsequent fishbowls that I define..

;; Ideally would do substructure redirect, so sawlets can't be
;; moved at all.

;; TODO: lots of config stuff possible...

;;;;

(define-structure merlin.fishbowl
  (export
   deffishbowl
   fishbowl-eject
   popup-fishbowl-menu)

  (open
   rep
   rep.regexp
   rep.system
   rep.io.timers
   sawfish.wm.colors
   sawfish.wm.commands
   sawfish.wm.events
   sawfish.wm.fonts
   sawfish.wm.frames
   sawfish.wm.menus
   sawfish.wm.placement
   sawfish.wm.misc
   sawfish.wm.stacking
   sawfish.wm.windows
   sawfish.wm.util.x
   merlin.sawlet
   merlin.util
   merlin.x-util)

  ;;

  (define (dimensions fishbowl)
    (let*
        ((fishes (sawlet-get fishbowl 'fish))
         (shrinkage (sawlet-config fishbowl 'shrinkage))
         (spacing (sawlet-config fishbowl 'spacing))
         (dim (cons (- spacing) 0)))
      (mapc
        (lambda (fish)
          (let ((d (cons- (cadr fish) (cons* shrinkage 2))))
            (rplaca dim (+ (car dim) (car d) spacing))
            (rplacd dim (max (cdr dim) (cdr d)))))
        fishes)
      (cons-max dim 4)))

  (define fishbowls nil)

  (define (start fishbowl)
    (setq fishbowls (nconc fishbowls (list fishbowl)))
    (mapc
      (lambda (window)
        (when (eq fishbowl (window-get window 'place-mode))
          (after-add-window-eye window)))
      (managed-windows)))
        
  (define (mapfish thunk fishbowl)
    (let*
        ((shrinkage (sawlet-config fishbowl 'shrinkage))
         (spacing (sawlet-config fishbowl 'spacing))
         (pos (cons- shrinkage))
         (fishes (sawlet-get fishbowl 'fish)))
      (mapc
        (lambda (fish)
          (thunk fish pos)
          (rplaca pos (- (+ (car pos) spacing (caadr fish)) (* 2 (car shrinkage)))))
        fishes)))

  (define (stop fishbowl)
    (let*
        ((base (window-position (sawlet-frame fishbowl))))
      (setq fishbowls (delq fishbowl fishbowls))
      (mapfish 
        (lambda (fish pos)
           (x-reparent-window (car fish) nil (cons+ base pos))
           (x-map-request (car fish)))
        fishbowl)
      (sawlet-put fishbowl 'fish nil)))

  (define (capture fishbowl)
    (let*
        ((window (select-window)))
      (when (and window (not (eq window (sawlet-frame fishbowl))))
        (window-put window 'place-mode fishbowl)
        (after-add-window-eye window))))

  (define (eject fishbowl id)
    (let*
        ((base (window-position (sawlet-frame fishbowl))))
      (mapfish
        (lambda (fish pos)
          (when (eq id (car fish))
            (sawlet-put fishbowl 'suspend t)
            (x-reparent-window id nil (cons+ base pos))
            (x-map-request id)
            (sawlet-put fishbowl 'suspend nil))) 
        fishbowl)
      (sawlet-put fishbowl 'fish
        (delete-if (lambda (fish) (eq id (car fish))) (sawlet-get fishbowl 'fish)))
      (sawlet-reconfigure fishbowl)))

(require 'rep.io.files)
(define (log a . rest)
  (let ((file (open-file "/tmp/log" 'append)))
    (format file "%s %s\n" a rest)
    (close-file file)))

  (define (replace fishbowl)
    (mapfish
      (lambda (fish pos)
        (x-configure-window (car fish) `((x . ,(car pos)) (y . ,(cdr pos)))))
      fishbowl))

  (define (place window))

  (define (after-add-window-eye window)
    (let*
        ((fishbowl (window-get window 'place-mode)))
      (when (and (memq fishbowl fishbowls) (not (sawlet-get fishbowl 'suspend)))
        (let*
            ((id (window-id window))
             (dim (window-dimensions window))
             (weight (or (window-get window 'placement-weight) -1))
             (fishes (cons nil (sawlet-get fishbowl 'fish))))
          (x-change-window-attributes id `((override-redirect . ,t)))
          (x-map-notify id) ; this removes it from window-manager
          (x-change-window-attributes id `((override-redirect . ,nil)))
          (x-configure-window id `((border-width . 0)))
          (x-reparent-window id (sawlet-get fishbowl 'window) (cons 0 0))
          (let loop ((rest fishes))
            (if (or (null (cdr rest)) (> (nth 2 (cadr rest)) weight))
                (rplacd rest (cons (list id dim weight) (cdr rest)))
              (loop (cdr rest))))
          (sawlet-put fishbowl 'fish (cdr fishes))
          (sawlet-reconfigure fishbowl)
          (x-x-map-window id)))))

  (add-hook 'after-add-window-hook after-add-window-eye)

  ;;

  (define (popup-fishbowl-menu window)
    (let*
        ((fishbowl (sawlet-from-frame window)))
      (when (memq fishbowl fishbowls)
        (popup-menu 
          `((,(_ "_Capture") ,(lambda () (capture fishbowl)))
            (,(_ "_Eject") .
            ,(mapcar
               (lambda (fish)
                 (list (aref (x-get-text-property (car fish) 'WM_NAME) 0)
                   (lambda () (eject fishbowl (car fish)))))
               (sawlet-get fishbowl 'fish))))))))

  (define-command 'popup-fishbowl-menu popup-fishbowl-menu #:spec "%W")

  ;;

  ; if I do substructure redirect events on the parent
  ; then this gets called instead of configure notify...
  ; but default sawfish just does the configure anyway
  ;;;; (define (configure-request-handler fishbowl event))

  (define (configure-notify-handler fishbowl event)
    (let
        ((id (cdr (assq 'window event)))
         (width (cdr (assq 'width event)))
         (height (cdr (assq 'height event)))
         (fishes (sawlet-get fishbowl 'fish)))
      (mapc
        (lambda (fish)
          (when (and (equal id (nth 0 fish)))
            (rplaca (cdr fish) (cons width height))
            (sawlet-reconfigure fishbowl))) fishes)))

  (define (destroy-notify-handler fishbowl event)
    (let*
        ((id (cdr (assq 'window event)))
         (fishes (sawlet-get fishbowl 'fish)))
      (sawlet-put fishbowl 'fish
        (delete-if (lambda (fish) (eq id (car fish))) fishes))
      (sawlet-reconfigure fishbowl)))

  (define (expose-handler fishbowl event) ;; todo: draw tiles + internal bars
    (x-clear-window (sawlet-get fishbowl 'window)))

  (define (button-press-handler fishbowl event)
    (popup-fishbowl-menu (sawlet-frame fishbowl)))

  (define (pre fishbowl)
    (define-placement-mode fishbowl place))

  (defmacro deffishbowl (fishbowl . keys)

    `(progn
      (require 'merlin.sawlet)
      ,(append
        `(defsawlet ,fishbowl
        :pre ,pre)
        keys ; allow override
        `(:start ,start
        :stop ,stop
        :post-configure ,replace
        :dimensions ,dimensions
        :expose-handler ,expose-handler
        :button-press-handler ,button-press-handler
        :destroy-notify-handler ,destroy-notify-handler
        :configure-notify-handler ,configure-notify-handler
;;;;    :configure-request-handler ,configure-request-handler
        :font ,nil
        :foreground ,nil
        :background ,(get-color-rgb 0 0 0)
        :defcustom (shrinkage (cons 0 0)
          "Shrinkage."
          :type (pair (number 0 8) (number 0 8))
          :after-set sawlet-reconfigure)
        :defcustom (spacing 4
          "Spacing."
          :type (number 0 8)
          :after-set sawlet-reconfigure)
        )))))
