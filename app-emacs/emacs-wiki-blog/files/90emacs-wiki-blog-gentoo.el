
;;; emacs-wiki-blog site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(load-library "emacs-wiki-blog")
(load-library "latex2png")
(load-library "plog")

(push '("latex" t t t gs-latex-tag) emacs-wiki-markup-tags)
(push '("thumb" t t t gs-emacs-wiki-thumbnail-tag) emacs-wiki-markup-tags)

(setq gs-latex2png-scale-factor 2.5)
