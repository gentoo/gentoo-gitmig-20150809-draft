# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/iiimecf/iiimecf-12.0.1_pre1891.ebuild,v 1.1 2004/09/13 20:03:48 usata Exp $

inherit elisp iiimf

DESCRIPTION="IIIMECF is a Emacs client framework for IIIMF"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/libiiimp
	dev-libs/libiiimcf"

src_compile() {
	emacs -q --no-site-file -batch -l iiimcf-comp.el
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install ${FILESDIR}/50iiimecf-gentoo.el
	dodoc ChangeLog README*
	newdoc lisp/ChangeLog ChangeLog.lisp
}
