;; merlin/x-util.jl -- some x utilities

;; version -0.3

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

(define-structure merlin.x-util

  (export
   x-map-fn
   x-configure-fn
   x-set-wm-name
   x-set-wm-icon-name
   x-set-wm-class
   x-set-wm-protocols
   x-set-wm-size-hints
   x-set-transient-for-hint
   any-window-id
   move-window-unconstrained
   move-window-initial-pointer-offset)

  (open
   rep
   rep.system
   sawfish.wm.misc
   sawfish.wm.util.x
   merlin.util)

  (define (x-map-fn)
    (if (wm-initialized) x-map-request x-x-map-window))

  (define (x-configure-fn)
    (if (wm-initialized) x-configure-request x-configure-window))

  (define (x-set-wm-name w name)
    (x-set-text-property w (vector name) 'WM_NAME))

  (define (x-set-wm-icon-name w name)
    (x-set-text-property w (vector name) 'WM_ICON_NAME))

  (define (x-set-wm-class w name class)
    (x-set-text-property w (vector name class) 'WM_CLASS))

  (define protocol-map `((delete-window . WM_DELETE_WINDOW)))

  (define (x-set-wm-protocols w protocols)
    (let*
        ((mapper (lambda (protocol) (cdr (assq protocol protocol-map))))
         (mapped (delete-if not (mapcar mapper protocols)))
         (atoms (mapcar x-atom mapped)))
      (x-change-property w 'WM_PROTOCOLS 'ATOM 32
        'prop-mode-replace (apply vector atoms))))

  (define (x-set-wm-size-hints w min max)
    (x-change-property w 'WM_NORMAL_HINTS 'WM_SIZE_HINTS 32 'prop-mode-replace
      (vector 48 0 0 0 0 (car min) (cdr min) (car max) (cdr max) 0 0 0 0 0 0 0)))

  (define (any-window-id window)
    (cond
      ((integerp window) window)
      ((windowp window) (window-id window))
      ((x-window-p window) (x-window-id window))
      (t (error "unknown window type: %s" window))))

  (define (x-set-transient-for-hint w parent)
    (if (null parent)
        (x-delete-property w 'WM_TRANSIENT_FOR)
      (x-change-property w 'WM_TRANSIENT_FOR 'WINDOW 32 'prop-mode-replace (vector (any-window-id parent)))))

  (defvar move-window-preprocessed nil) ;; private
  (defvar move-window-unconstrained nil) ;; allow move resize beyond screen bounds
  (defvar move-window-initial-pointer-offset nil) ;; set/get initial pointer offset in window

  (add-hook 'after-move-hook
    (lambda (w dirs)
      (setq move-window-preprocessed nil)
      (setq move-window-unconstrained nil)
      (setq move-window-initial-pointer-offset nil)))
)
