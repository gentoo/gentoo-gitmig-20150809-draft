# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/iiimecf/iiimecf-11.4.1467.ebuild,v 1.1 2003/09/14 00:47:30 usata Exp $

inherit elisp iiimf

IUSE=""

DESCRIPTION="IIIMECF is a Emacs client framework for IIIMF"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="dev-libs/libiiimp
	dev-libs/libiiimcf"

src_compile() {

	emacs -q --no-site-file -batch -l iiimcf-comp.el
}

src_install() {

	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install ${FILESDIR}/50iiimecf-gentoo.el
	dodoc ChangeLog README* COPYING
	newdoc lisp/ChangeLog ChangeLog.lisp
}
