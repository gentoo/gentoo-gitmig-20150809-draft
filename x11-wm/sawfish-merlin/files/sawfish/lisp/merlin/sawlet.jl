;; merlin/sawlet.jl -- a bad saw(fish app)let framework

;; version -0.3.3

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

;; Please see one of the actual sawlets

;; Go to Customize->Matched Windows->Sawlet->Edit...
;;      - Here you can specify settings for all sawlets

;;;;;;;;;;;;;;;;;;
;; HERE BE BUGS ;;
;;;;;;;;;;;;;;;;;;

;; sawlet's can be per-workspace but not be per-viewport.
;; sawlet defcustom/defgroup :group has to be a list, not a symbol.

;; TODO: auto-remember sawlet position

;; TODO: defsawlet :match-window settings

;;;;

(define-structure merlin.sawlet
  (export
   defsawlet
   sawlet-start
   sawlet-reconfigure
   sawlet-stop
   sawlet-active
   sawlet-get
   sawlet-put
   sawlet-config
   sawlet-frame
   sawlet-from-frame
   sawlet-symbol)

  (open
   rep
   rep.system
   sawfish.wm.colors
   sawfish.wm.custom
   sawfish.wm.events
   sawfish.wm.fonts
   sawfish.wm.misc
   sawfish.wm.windows
   sawfish.wm.ext.match-window
   sawfish.wm.util.x
   merlin.sawlet-placement
   merlin.util
   merlin.x-util)

  (defgroup sawlets "Sawlets")

  (defcustom merlin.sawlet:default-placement:origin 'north-east
    "Default placement origin."
    :type (choice north-west north-east south-east south-west)
    :group sawlets
    :after-set (lambda () (define-default-sawlet-placement-mode)))

  (defcustom merlin.sawlet:default-placement:direction 'west
    "Default placement direction."
    :type (choice north east south west)
    :group sawlets
    :after-set (lambda () (define-default-sawlet-placement-mode)))

  (define (syms symbol . rest)
    (intern
      (apply concat
        (list*
          (format nil "%s" symbol)
          (mapcar (lambda (sym) (format nil "-%s" sym)) rest)))))

  (define (sawlet-symbol sawlet symbol)
     (intern (format nil "merlin.sawlet:%s:%s" sawlet symbol)))

  (define (sawlet-get sawlet key)
    (get sawlet key))

  (define (sawlet-put sawlet key value #!optional destructor)
    (let
        ((old (get sawlet key)))
      (and old destructor (destructor old))
      (put sawlet key value)))

  (define (sawlet-config sawlet key)
    (symbol-value (sawlet-symbol sawlet key)))

  (define (sawlet-call sawlet command . args)
    (let
        ((cmd (sawlet-get sawlet command)))
      (and cmd (apply cmd args))))

  (define (sawlet-frame sawlet)
    (get-window-by-id (x-window-id (sawlet-get sawlet 'root))))

  (define (sawlet-from-frame window)
    (window-get window 'merlin.sawlet:sawlet))

  (define (sawlet-root-client-message event)
    (let*
        ((window (cdr (assq 'window event)))
         (sawlet (x-window-get window 'sawlet))
         (message-type (cdr (assq 'message-type event)))
         (fmt (cdr (assq 'format event)))
         (data (cdr (assq 'data event))))
      (when (and (eq message-type 'WM_PROTOCOLS)
                 (eq fmt 32)
                 (eq (aref data 0) (x-atom 'WM_DELETE_WINDOW)))
        (sawlet-stop sawlet))))

  (define (sawlet-root-event-handler type window event)
    (cond
      ((eq type 'client-message) (sawlet-root-client-message event))))

  (define (sawlet-window-event-handler type window event)
    (let*
        ((sawlet (x-window-get window 'sawlet))
         (handler (sawlet-get sawlet (syms type 'handler))))
      (when handler
        (handler sawlet event))))

  (define event-mask-map
    `((expose . exposure)
      (button-press . button-press)
      (enter-notify . enter-window)
      (destroy-notify . substructure-notify)
      (configure-notify . substructure-notify)
      (configure-request . substructure-redirect)))

  (define (sawlet-create sawlet)
    (let*
        ((dims (or (sawlet-call sawlet 'dimensions sawlet) (cons 64 64)))
         (bw (car (sawlet-config sawlet 'border)))
         (root-dims (cons+ dims (* 2 bw)))
         (root (x-create-window
           (cons 0 0)
           root-dims
           0
           `((override-redirect . ,nil)
             (event-mask . ()))
           sawlet-root-event-handler))
         (window (x-create-window
           (cons 0 0)
           dims
           bw
           `((parent . ,root)
             (background . ,(sawlet-config sawlet 'background))
             (border-color . ,(cdr (sawlet-config sawlet 'border)))
             (override-redirect . ,t)
             (event-mask .
               ,(mapcar (lambda (map)
                 (and (sawlet-get sawlet (syms (car map) 'handler))
                   (cdr map))) event-mask-map)))
           sawlet-window-event-handler))
         (gc (x-create-gc
           root
           (and (boundp (sawlet-symbol sawlet 'foreground))
             `(foreground . ,(sawlet-config sawlet 'foreground))))))
      (x-window-put window 'sawlet sawlet)
      (x-window-put root 'sawlet sawlet)
      (sawlet-put sawlet 'gc gc x-free-gc)
      (sawlet-put sawlet 'window window x-destroy-window)
      (sawlet-put sawlet 'root root x-destroy-window)
      (x-set-wm-class
        root
        (format nil "%s" sawlet)
        "Sawlet")
      (x-set-wm-name
        root
        (or (sawlet-get sawlet 'name) (format nil "%s" sawlet)))
      (x-set-wm-icon-name
        root
        (or (sawlet-get sawlet 'icon-name) (format nil "%s" sawlet)))
      (x-set-wm-protocols
        root
        '(delete-window))
      (x-set-wm-size-hints
        root
        dims
        dims)
      (x-x-map-window
        window)
      ((x-map-fn)
        root)))

  (define (sawlet-destroy sawlet)
    (sawlet-put sawlet 'gc nil x-free-gc)
    (sawlet-put sawlet 'window nil x-destroy-window)
    (sawlet-put sawlet 'root nil x-destroy-window))

  (define (sawlet-configure sawlet)
    (let*
        ((dims (or (sawlet-call sawlet 'dimensions sawlet) (cons 64 64)))
         (bw (car (sawlet-config sawlet 'border)))
         (root-dims (cons+ dims (* 2 bw))))
      (x-set-wm-size-hints
        (sawlet-get sawlet 'root)
        root-dims
        root-dims)
      ((x-configure-fn)
        (sawlet-get sawlet 'root)
        `((width . ,(car root-dims))
          (height . ,(cdr root-dims))))
      (x-configure-window
        (sawlet-get sawlet 'window)
        `((width . ,(car dims))
          (height . ,(cdr dims))
          (border-width . ,bw)))
      (x-change-window-attributes
        (sawlet-get sawlet 'window)
        `((background . ,(sawlet-config sawlet 'background))
          (border-color . ,(cdr (sawlet-config sawlet 'border)))))
      (when (boundp (sawlet-symbol sawlet 'foreground))
        (x-change-gc
          (sawlet-get sawlet 'gc)
          `((foreground . ,(sawlet-config sawlet 'foreground)))))))

  ;; pub
  
  (define sawlets nil)

  (define (add-window-eye window)
    (mapc
      (lambda (sawlet)
        (when (eq window (sawlet-frame sawlet))
          (window-put window 'merlin.sawlet:sawlet sawlet)))
      sawlets))

  (add-hook 'add-window-hook add-window-eye)

  (define (sawlet-start sawlet)
    (unless (memq sawlet sawlets)
      (setq sawlets (nconc sawlets (list sawlet)))
      (sawlet-create sawlet)
      (sawlet-call sawlet 'start sawlet)))

  (define (sawlet-reconfigure sawlet)
    (when (memq sawlet sawlets)
      (sawlet-call sawlet 'pre-configure sawlet)
      (sawlet-configure sawlet)
      (sawlet-call sawlet 'post-configure sawlet)
      (sawlet-call sawlet 'expose-handler sawlet `((window . ,(sawlet-get sawlet 'window)))))) ;; hack!!

  (define (sawlet-stop sawlet)
    (when (sawlet-get sawlet 'root)
      (setq sawlets (delq sawlet sawlets))
      (sawlet-call sawlet 'stop sawlet)
      (sawlet-destroy sawlet)))

  (define (sawlet-active sawlet)
    (and (sawlet-get sawlet 'root) t))

  (define (define-default-sawlet-placement-mode)
    (define-sawlet-placement-mode 'sawlet
      merlin.sawlet:default-placement:origin
      merlin.sawlet:default-placement:direction))

  (define-default-sawlet-placement-mode)

  (defmacro defsawlet
    (sawlet #!rest keys)
      (let*
        ((Sawlet (capitalize-string (format nil "%s" sawlet)))
         (class (format nil "^Sawlet/%s$" sawlet))
         (fmt (lambda (sym) (intern (format nil ":%s" sym))))
         (get (lambda (sym) (cadr (memq (fmt sym) keys))))
         (no (lambda (sym) (and (memq (fmt sym) keys) (not (get sym)))))
         (start-stop
           (lambda ()
             (if (sawlet-config sawlet 'enabled)
                 (sawlet-start sawlet)
               (sawlet-stop sawlet))))
         (configure
           (lambda ()
             (sawlet-reconfigure sawlet))))

      (append
      `(progn
        (require 'sawfish.wm.colors)
        (require 'sawfish.wm.custom)
        (require 'sawfish.wm.fonts)
        (require 'sawfish.wm.ext.match-window)

        (sawlet-put ',sawlet 'sawlet t
          (lambda () (error "Sawlet %s already defined." ',sawlet)))

        (defgroup ,sawlet ,Sawlet :group sawlets))

      (mapcar ;; todo: ALL handlers!
        (lambda (symbol)
          `(sawlet-put ',sawlet ',symbol ,(get symbol)))
        '(pre post init start stop pre-configure post-configure name icon-name
          dimensions expose-handler button-press-handler
          enter-notify-handler destroy-notify-handler
          configure-notify-handler configure-request-handler))

      (delq nil (mapcar
        (lambda (def)
          (let*
              ((name (nth 0 def))
               (symbol (sawlet-symbol sawlet name))
               (value (or (get name) (nth 1 def)))
               ;(doc (format nil "%s %s." Sawlet (nth 2 def)))
               (doc (nth 2 def))
               (type (nth 3 def))
               (after-set (nth 4 def)))
            (and (not (no name)) `(defcustom ,symbol ,value ,doc
              :type ,type :group (sawlets ,sawlet) :after-set ,after-set))))
        `((enabled t "Enabled." boolean ,start-stop)
          (font default-font "Font." font ,configure)
          (foreground (get-color-rgb 0 0 0) "Foreground color." color ,configure)
          (background (get-color-rgb 65535 65535 65535) "Background color." color ,configure)
          (border (cons 0 (get-color-rgb 0 0 0)) "Internal border." (pair (labelled "Width:" (number 0 100)) (labelled "Color:" color)) ,configure))))

      (nreverse
        (let loop ((rest keys) (defs nil))
          (if (not rest)
              defs
            (when (eq ':defgroup (car rest))
              (let*
                  ((def (append (cadr rest) ())) ; copy list
                   (group (memq ':group def)))
                (if group ;; TODO: group can be a symbol
                    (rplaca (cdr group) (list* 'sawlets sawlet (cadr group)))
                  (nconc def `(:group (sawlets ,sawlet))))
                (setq defs (cons (cons 'defgroup def) defs))))
            (loop (cddr rest) defs))))

      (nreverse
        (let loop ((rest keys) (defs nil))
          (if (not rest)
              defs
            (when (eq ':defcustom (car rest))
              (let*
                  ((def (append (cadr rest) ())) ; copy list
                   (name (nth 0 def))
                   (symbol (sawlet-symbol sawlet name))
                   (value (or (get name) (nth 1 def)))
                   (group (memq ':group def))
                   (after-set (memq ':after-set def))
                   (depends (memq ':depends def)))
                (rplaca def symbol)
                (rplaca (cdr def) value)
                (if group ;; TODO: group can be a symbol
                    (rplaca (cdr group) (list* 'sawlets sawlet (cadr group)))
                  (nconc def `(:group (sawlets ,sawlet))))
                (when depends
                  (rplaca (cdr depends) (sawlet-symbol sawlet (cadr depends))))
                (when after-set
                  (rplaca (cdr after-set) `(lambda () (,(cadr after-set) ',sawlet))))
                (setq defs (cons (cons 'defcustom def) defs))))
            (loop (cddr rest) defs))))

      `((unless
          (catch 'out
            (mapc
              (lambda (entry)
                (when (member (cons 'WM_CLASS ,class) (car entry))
                  (throw 'out t)))
              match-window-profile)
             nil)
         (setq match-window-profile
           (nconc match-window-profile (list (list (list (cons 'WM_CLASS ,class))))))
         (add-window-matcher 'WM_CLASS ,class))

        (when (sawlet-get ',sawlet 'pre)
          ((sawlet-get ',sawlet 'pre) ',sawlet))

        (when (sawlet-get ',sawlet 'init)
          ((sawlet-get ',sawlet 'init) ',sawlet))

        (when (and (not batch-mode) (sawlet-config ',sawlet 'enabled))
          (sawlet-start ',sawlet))

        (when (sawlet-get ',sawlet 'post)
          ((sawlet-get ',sawlet 'post) ',sawlet))

        (defvar ,sawlet ',sawlet))))) ;; define??

  (unless
    (catch 'out
      (mapc
        (lambda (entry)
          (when (member (cons 'WM_CLASS "^Sawlet/") (car entry))
            (throw 'out t)))
         match-window-profile)
       nil)
    (setq match-window-profile ;; put at end...
       (nconc match-window-profile (list (list (list (cons 'WM_CLASS "^Sawlet/"))))))
    (add-window-matcher 'WM_CLASS "^Sawlet/"
                        '(place-mode . sawlet)
                        '(never-focus . t)
                        '(sticky . t)
                        '(sticky-viewport . t)
                        '(window-list-skip . t)
                        '(skip-tasklist . t)
                        '(frame-type . border-only))))
