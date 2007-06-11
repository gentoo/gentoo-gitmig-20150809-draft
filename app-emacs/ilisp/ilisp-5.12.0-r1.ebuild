# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ilisp/ilisp-5.12.0-r1.ebuild,v 1.8 2007/06/11 10:52:15 opfer Exp $

inherit elisp

DESCRIPTION="A comprehensive (X)Emacs interface for an inferior Common Lisp, or other Lisp based languages"
HOMEPAGE="http://sourceforge.net/projects/ilisp/"
SRC_URI="mirror://sourceforge/ilisp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""

src_compile() {
	make EMACS=emacs SHELL=/bin/sh || die
	cd extra
	for i in *.el
	do
		emacs -batch -eval "(byte-compile-file \"$i\")"
	done
}

src_install() {
	elisp-install ${PN} *.el *.elc *.lisp *.scm
	elisp-install ${PN}/extra extra/*.el extra/*.elc
	elisp-site-file-install ${FILESDIR}/50ilisp-gentoo.el
	dodoc ACKNOWLEDGMENTS GETTING-ILISP HISTORY INSTALLATION README Welcome
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
