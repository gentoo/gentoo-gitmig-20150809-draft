
;;; ilisp site-lisp configuration (most of this was shamelessly yanked
;;; from the ilisp.emacs file distributed with ilisp)

(add-to-list 'load-path "@SITELISP@")
(add-to-list 'load-path "@SITELISP@/extra")

(autoload 'common-lisp "ilisp" "Inferior generic Common Lisp." t)
; (autoload 'allegro "ilisp" "Inferior Allegro Common Lisp." t)
; (autoload 'cormanlisp "ilisp" "Inferior Corman Common Lisp." t)
; (autoload 'lucid "ilisp" "Inferior Lucid Common Lisp." t)
; (autoload 'lispworks "ilisp" "Inferior Harlequin Common Lisp (LispWorks)." t)
; (autoload 'harlequin "ilisp" "Inferior Harlequin Common Lisp (LispWorks)." t)
; (autoload 'pulcinella "ilisp" "Inferior Harlequin Common Lisp (LispWorks)." t)
(autoload 'cmulisp "ilisp" "Inferior CMU Common Lisp." t)
(autoload 'clisp-hs "ilisp" "Inferior Haible/Stoll CLISP Common Lisp." t)
; (autoload 'kcl "ilisp" "Inferior Kyoto Common Lisp." t)
; (autoload 'akcl "ilisp" "Inferior Austin Kyoto Common Lisp." t)
; (autoload 'ibcl "ilisp" "Ibuki Common Lisp." t)
(autoload 'gcl "ilisp" "Inferior GNU Common Lisp." t)
; (autoload 'ecl "ilisp" "Inferior EcoLisp." t)
; (autoload 'xlisp "ilisp" "Inferior XLisp." t)
; (autoload 'xlispstat "ilisp" "Inferior XLisp-Stat." t)
(autoload 'scheme "ilisp" "Inferior generic Scheme." t)
; (autoload 'oaklisp "ilisp" "Inferior Oaklisp Scheme." t)
; (autoload 'scm "ilisp" "Inferior SCM Scheme." t)
; (autoload 'chez "ilisp" "Inferior Chez Scheme." t)
; (autoload 'stk "ilisp" "Inferior STk Scheme." t)
; (autoload 'snow "ilisp" "Inferior STk Scheme without Tk." t)
(autoload 'guile "ilisp" "Inferior GUILE Scheme." t)

; (setq allegro-program "/usr/local/acl5/lisp")
; (setq lucid-program "/usr/misc/.lucid/bin/lisp")
(setq clisp-hs-program "/usr/bin/clisp -I")
; (setq *cormanlisp-dir* "C:\\CORMAN~1\\CORMAN~1.5\\")
; (setq cormanlisp-program
;      (concat *cormanlisp-dir* "clconsole.exe" 
;	       " -image " *cormanlisp-dir* "CormanLisp.img"))
; (setq lispworks-program
;       "/somewhere/in/the/directory/tree/lispworks")
(setq cmulisp-program "/usr/bin/lisp")
;; If you are interested in maintaining CMUCL or compiling it
;; from source then set this to where the source files are.
; (setq cmulisp-local-source-directory
;       "/usr/robotics/shared/cmu-cl/17e/")
; (setq akcl-program "kcl")
; (setq gcl-program "gcl")
; (setq ecl-program "ecl")
; (setq xlisp-program "xlisp")
; (setq xlispstat-program "xlispstat")
; (setq scm-program "scm -i")
; (setq chez-program "petite")
; (setq stk-program "stk -interactive")
; (setq snow-program "snow -interactive")
(setq guile-program "/usr/bin/guile")

(set-default 'auto-mode-alist
	     (append '(("\\.lisp$" . lisp-mode)
                       ("\\.lsp$" . lisp-mode)
                       ("\\.cl$" . lisp-mode))
                     auto-mode-alist))
(add-hook 'lisp-mode-hook '(lambda () (require 'ilisp)))

(set-default 'auto-mode-alist
             (append '(("\\.scm$" . scheme-mode)
                       ("\\.ss$" . scheme-mode)
                       ("\\.stk$" . scheme-mode)
                       ("\\.stklos$" . scheme-mode))
                     auto-mode-alist))
(add-hook 'scheme-mode-hook '(lambda () (require 'ilisp)))

;;; Configuration of Erik Naggum's HyperSpec access package.
;; If you have a local copy of the HyperSpec, set its path here.
; (setq common-lisp-hyperspec-root
;       "file:/home/joe/HyperSpec/")
; (setq common-lisp-hyperspec-symbol-table
;       "/home/joe/HyperSpec/Data/Map_Sym.Txt")
;; Here's how to get the newest version of the CLHS:
;; <http://groups.google.com/groups?selm=sfwvgftux7g.fsf%40shell01.TheWorld.com>

;;; Configuration of Utz-Uwe Haus' CLtL2 access package.
;; If you have a local copy of CLtL2, set its path here.
; (setq cltl2-root-url
;       "file:/home/joe/cltl2/")

;;; Sample load hook
(add-hook 'ilisp-load-hook
          '(lambda ()
             ;; Change default key prefix to C-c
;;             (setq ilisp-*prefix* "\C-c")

             ;; Set a keybinding for the COMMON-LISP-HYPERSPEC command
;;              (defkey-ilisp "" 'common-lisp-hyperspec)

             ;; Make sure that you don't keep popping up the 'inferior
             ;; Lisp' buffer window when this is already visible in
             ;; another frame. Actually this variable has more impact
             ;; than that. Watch out.
             ; (setq pop-up-frames t)

             (message "Running ilisp-load-hook")
             ;; Define LispMachine-like key bindings, too.
             ; (ilisp-lispm-bindings) Sample initialization hook.

             ;; Set the inferior Lisp directory to the directory of
             ;; the buffer that spawned it on the first prompt.
             (add-hook 'ilisp-init-hook
                       '(lambda ()
                          (default-directory-lisp ilisp-last-buffer)))))
