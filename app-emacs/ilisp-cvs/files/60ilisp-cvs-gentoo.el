;; -*-emacs-lisp-*-
;;
;; Emacs startup file for the Debian GNU/Linux ilisp package
;;
;; Originally contributed by Nils Naumann <naumann@unileoben.ac.at>
;; Modified by Dirk Eddelbuettel <edd@debian.org>
;; Adapted for dh-make by Jim Van Zandt <jrv@vanzandt.mv.com>

;; Modified for Gentoo by Matthew Kennedy <mkennedy@gentoo.org>

(add-to-list 'load-path "@SITELISP@")
(add-to-list 'load-path "@SITELISP@/extra")

(if (file-readable-p "~/.ilisp")
    (load "~/.ilisp")
  (load "/etc/ilisp/ilisp.el"))
