# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ocaml-mode/ocaml-mode-3.09.3.ebuild,v 1.1 2007/03/30 16:29:50 opfer Exp $

inherit elisp

MY_P=${P/-mode/}

DESCRIPTION="Emacs mode for OCaml"
HOMEPAGE="http://www.ocaml.org/"
SRC_URI="http://caml.inria.fr/distrib/${MY_P}/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=""

S="${WORKDIR}/${MY_P}/emacs"
SITEFILE=50ocaml-mode-gentoo.el

src_compile() {
	COMPILECMD='(progn
			  (setq load-path (cons "." load-path))
			  (byte-compile-file "caml-xemacs.el")
			  (byte-compile-file "caml-emacs.el")
			  (byte-compile-file "caml-types.el")
			  (byte-compile-file "caml-hilit.el")
			  (byte-compile-file "caml-font.el")
			  (byte-compile-file "caml.el")
			  (byte-compile-file "inf-caml.el")
			  (byte-compile-file "caml-help.el")
			  (byte-compile-file "camldebug.el"))'
	emacs -batch -eval "${COMPILECMD}"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
