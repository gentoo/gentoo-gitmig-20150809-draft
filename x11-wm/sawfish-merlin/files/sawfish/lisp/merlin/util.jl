;; merlin/util.jl -- some utilities

;; version 0.7.3

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

(define-structure merlin.util

  (export
   fontify
   colorify
   wm-initialized
   percent
   assqd
   split
   index-of
   rplac
   cons-op
   op-cons
   cons+ cons- cons* cons% cons/ cons< cons> cons<= cons>= cons= cons%/ cons/%
   cons-percent cons-quotient cons-min cons-max cons-and cons-or
   and-cons or-cons +cons
   trim
   gravitate
   screen-dimensions
   viewport-offset
   ceil)

  (open
   rep
   rep.regexp
   rep.system
   sawfish.wm.colors
   sawfish.wm.fonts
   sawfish.wm.misc
   sawfish.wm.windows)

  ;; string/font -> font
  (define (fontify font)
    (if (stringp font) (get-font font) font))

  ;; string/color -> color
  (define (colorify color)
    (if (stringp color) (get-color color) color))

  (define after-initialization nil)

  (add-hook 'after-initialization-hook
    (lambda () (setq after-initialization t)))

  ;; is the window manager initialized yet
  (define (wm-initialized) ;; a hack
    (or after-initialization (managed-windows)))

  ;; b % of a
  (define (percent a b)
    (quotient (* a b) 100))

  ;; assq with default
  (define (assqd key alist default)
    (if (assq key alist)
      (assq key alist)
      (cons key default)))

  ;; split of "" is ("")
  (define (split string separator)
    (let
	((n (length string))
	 (m (length separator))
	 (point 0)
	 out end)
      (while (<= point n)
	(setq end (if (string-match separator string point)
		      (match-start)
		    (length string)))
	(setq out (cons (substring string point end) out))
	(setq point (+ m end)))
      (nreverse out)))

  ;; the index of item in list or -1
  (define (index-of item list)
    (let loop ((rest list) (i 0))
      (cond
       ((null rest) -1)
       ((eq (car rest) item) i)
       (t (loop (cdr rest) (1+ i))))))

  ;; replace car and cdr
  (define (rplac a b)
    (rplaca a (car b))
    (rplacd a (cdr b)))

  ;; op of cons cells and values
  (define (cons-op op a . rest)
    (let
        ((cars (mapcar (lambda (x) (if (consp x) (car x) x)) (list* a rest)))
         (cdrs (mapcar (lambda (x) (if (consp x) (cdr x) x)) (list* a rest))))
      (cons (apply (or (car op) op) cars) (apply (or (cdr op) op) cdrs))))

  ;; op of car and cdr
  (define (op-cons op a)
    (op (car a) (cdr a)))

  (defmacro defcons-ops ops
    (append `(progn) (apply append (mapcar (lambda (op)
      (let*
          ((name (or (car op) op))
           (func (or (cdr op) op))
           (alpha (alpha-char-p (aref (symbol-name name) 0)))
           (consop (intern (format nil (if alpha "cons-%s" "cons%s") name)))
           (opcons (intern (format nil (if alpha "%s-cons" "%scons") name))))
        `((define (,consop a . rest) (apply cons-op ,func a rest))
          (define (,opcons a) (op-cons ,func a))))) ops))))
        
  (define (myand . args) (let loop ((a args))
    (if (or (null (cdr a)) (not (car a))) (car a) (loop (cdr a)))))

  (define (myor . args) (let loop ((a args))
    (if (or (null (cdr a)) (car a)) (car a) (loop (cdr a)))))

  (defcons-ops + - * % / < > <= >= = percent quotient min max
    (and . myand) (or . myor) (%/ . (cons % quotient)) (/% . (cons quotient %)))

  ;; trim text in specified font to specified width, appending ...
  (define (trim text font width)
    (if (<= (text-width text font) width)
	text
      (let loop ((s (concat text "...")) (n (length text)))
	   (if (or (= 0 n) (<= (text-width s font) width))
	       s
	     (aset s (1- n) 46)
	     (loop (substring s 0 (+ 2 n)) (1- n))))))

  ;; return position of object of specified dimensions gravitated around speified point
  (define (gravitate pos dim gravity)
    (cons (cond ((memq gravity '(north center south)) (- (car pos) (quotient (car dim) 2)))
		((memq gravity '(north-west west south-west)) (- (car pos) (car dim)))
		(t (car pos)))
	  (cond ((memq gravity '(west center east)) (- (cdr pos) (quotient (cdr dim) 2)))
		((memq gravity '(north-west north north-west)) (- (cdr pos) (cdr dim)))
		(t (cdr pos)))))

  ;; screen dimensions
  (define (screen-dimensions)
    (cons (screen-width) (screen-height)))

  ;; viewport offset
  (define (viewport-offset)
    (cons viewport-x-offset viewport-y-offset))

  ;; ceiling quotient
  (define (ceil a b)
    (quotient (+ a (1- b)) b)))
