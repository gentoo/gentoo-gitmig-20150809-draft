
;;; anthy site-lisp configuration

(push "/usr/share/emacs/site-lisp/anthy" load-path)
(load-library "anthy")
(set-language-environment "Japanese")
(setq default-input-method "japanese-anthy")
