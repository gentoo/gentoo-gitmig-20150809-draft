;; merlin/uglicon.jl -- window icons

;; version 0.2

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
;;   mv uglicon.jl ~/.sawfish/lisp/merlin

;; You also need merlin/util.jl and probably want merlin/ugliness.jl.

(define-structure merlin.uglicon

  (export
   get-window-icon)

  (open
   rep
   rep.io.files
   sawfish.wm.colors
   sawfish.wm.custom
   sawfish.wm.images
   sawfish.wm.misc
   sawfish.wm.ext.match-window
   sawfish.wm.windows.subrs
   merlin.util)

  (defgroup uglicon "Window icons" :group appearance)

  (defcustom uglicon-ignore-hints t
    "Ignore icons from window hints."
    :type boolean
    :group (appearance uglicon)
;   :depends cycle-show-window-icons
    :after-set (lambda () (uglicon-reset)))

  (defcustom uglicon-search-filesystem t
    "Search the file system for window icons."
    :type boolean
    :group (appearance uglicon)
;   :depends cycle-show-window-icons
    :after-set (lambda () (uglicon-reset)))

  (defcustom uglicon-path "/usr/share/pixmaps:/usr/share/icons"
    "Path to search for icons."
    :tooltip "Colon separated paths."
    :type string
    :user-level expert
    :group (appearance uglicon)
    :depends uglicon-search-filesystem
    :after-set (lambda () (uglicon-reset)))

  (defcustom uglicon-prefixes ",gnome-"
    "Icon prefixes to look for."
    :tooltip "Comma separated prefixes."
    :type string
    :user-level expert
    :group (appearance uglicon)
    :depends uglicon-search-filesystem
    :after-set (lambda () (uglicon-reset)))

  (defcustom uglicon-suffixes "png,xpm"
    "Icon suffixes to look for."
    :tooltip "Comma separated suffixes."
    :type string
    :user-level expert
    :group (appearance uglicon)
    :depends uglicon-search-filesystem
    :after-set (lambda () (uglicon-reset)))

  (defcustom uglicon-width 48
    "Maximum width of window icons."
    :type number
    :range (1 . 128)
    :user-level expert
    :group (appearance uglicon))

  (defcustom uglicon-height 48
    "Maximum height of window icons."
    :type number
    :range (1 . 128)
    :user-level expert
    :group (appearance uglicon))

  (define-match-window-property 'window-icon 'appearance 'file)

  (define uglicon-cache) ;; TODO: periodically purge the cache?
  (define uglicon-split-path)
  (define uglicon-split-suffixes)
  (define uglicon-split-prefixes)

  (define (uglicon-reset)
    (setq uglicon-cache '())
    (setq uglicon-split-path (split uglicon-path ":"))
    (setq uglicon-split-suffixes (split uglicon-suffixes ","))
    (setq uglicon-split-prefixes (split uglicon-prefixes ",")))

  (uglicon-reset)

  ;; returns a cons cell of the key and entry
  (define (cache-get key creator)
    (let ((cached (cdr (assoc key uglicon-cache))))
      (unless cached
        (when (setq cached (creator))
	  (setq uglicon-cache (cons (cons key cached) uglicon-cache))))
      (and cached (cons key cached))))

  (define (load-icon file)
    (cache-get file
      (lambda ()
	(when (file-exists-p file)
	  (make-image file)))))

  (define (locate-icon name)
    (cache-get name
      (lambda ()
	(catch 'out
	  (mapc
	   (lambda (dir)
	     (mapc
	       (lambda (prefix)
		 (mapc
		  (lambda (suffix)
		    (let ((where (expand-file-name (concat prefix name "." suffix) dir)))
		      (when (file-exists-p where)
			(throw 'out (make-image where)))))
		  uglicon-split-suffixes))
	      uglicon-split-prefixes))
	    uglicon-split-path)
	  nil))))

  (define (window-icon window) ;; TODO: this should not really be cached; should provide a purge mechanism...
    (cache-get (format nil "win<0x%x>" (window-id window))
      (lambda ()
	(window-icon-image window))))

  (define (scale-icon icon max)
    (let ((key (format nil "%s-scale:%dx%d" (car icon) (car max) (cdr max))))
      (cache-get key
        (lambda ()
	  (let ((dims (image-dimensions (cdr icon))))
	    (if (and (<= (car dims) (car max)) (<= (cdr dims) (cdr max)))
	        (cdr icon)
	      (scale-image (cdr icon)
	        (min (car max) (quotient (* (car dims) (cdr max)) (cdr dims)))
		(min (cdr max) (quotient (* (car max) (cdr dims)) (car dims))))))))))

  (define (fade-icon icon fade)
    (let*
        ((rgb (color-rgb-8 fade))
         (key (format nil "%s-fade:%02x/%02x/%02x" (car icon) (nth 0 rgb) (nth 1 rgb) (nth 2 rgb))))
      (cache-get key
        (lambda ()
	  (let ((icon (copy-image (cdr icon))))
	    (image-map
	      (lambda (pixel)
	        (list
		  (quotient (+ (nth 0 pixel) (nth 0 rgb)) 2)
		  (quotient (+ (nth 1 pixel) (nth 1 rgb)) 2)
		  (quotient (+ (nth 2 pixel) (nth 2 rgb)) 2)
		  (nth 3 pixel))) icon) icon)))))

  (define (unknown-icon)
    (or (and uglicon-search-filesystem (locate-icon "unknown"))
      (cache-get "unknown"
	(lambda () ;; TODO: Make it pretty
	  (bevel-image (make-sized-image uglicon-width uglicon-height (get-color "gray")) 2 t 50)))))

  (define (window-icon-name window)
    (let ((class (get-x-text-property window 'WM_CLASS)))
      (and class (>= (length class) 2)
        (translate-string (aref class 1) downcase-table))))

  (define (get-window-icon window #!key (max-size (cons uglicon-width uglicon-height)) (fade-to nil))
    (let ((icon (or (and (window-get window 'window-icon) (load-icon (window-get window 'window-icon)))
		    (and (not uglicon-ignore-hints) (window-icon window))
		    (and uglicon-search-filesystem (window-icon-name window) (locate-icon (window-icon-name window)))
		    (unknown-icon))))
      (setq icon (scale-icon icon max-size))
      (when fade-to
        (setq icon (fade-icon icon fade-to)))
      (cdr icon))))
