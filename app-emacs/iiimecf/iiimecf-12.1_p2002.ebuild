# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/iiimecf/iiimecf-12.1_p2002.ebuild,v 1.3 2007/07/04 22:54:24 opfer Exp $

inherit elisp iiimf

DESCRIPTION="An Emacs client framework for IIIMF"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${IMSDK_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="app-emacs/mule-ucs
	dev-libs/libiiimp
	dev-libs/libiiimcf"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	emacs -q --no-site-file -batch -l iiimcf-comp.el
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog README*
	newdoc lisp/ChangeLog ChangeLog.lisp
}
