
;;; aspectj4emacs site-lisp configuration
(add-to-list 'load-path "@SITELISP@")
(require 'aspectj-mode)
(require 'ajdee)
 
;;; JDEE/speedbar settings to make it behave better for AspectJ.  You might
;;; want to do this via a prj.el file (see sample.prj) if you program in
;;; vanilla Java as well.  The sample.prj has settings for spacewar, a more
;;; complicated project.
(custom-set-variables
 '(jde-compiler '("ajc" "ajc"))		; ajc is AspectJ's compiler
 '(jde-javadoc-command-path "ajdoc"))
 
;;; The following are settings recommened by AspectJ for Emacs' author

(custom-set-variables
 ;; Widen the speedbar to show more of AJ's longer tag names.
 '(speedbar-frame-parameters
   (quote ((minibuffer) (width . 30) (border-width . 0) (menu-bar-lines . 0)
           (unsplittable . t))))
 ;; Don't let speedbar split into submenus smaller than 40 items
 '(speedbar-tag-split-minimum-length 40))
