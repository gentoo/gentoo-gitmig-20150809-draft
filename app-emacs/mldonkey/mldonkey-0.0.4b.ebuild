# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mldonkey/mldonkey-0.0.4b.ebuild,v 1.1 2005/04/06 14:38:04 usata Exp $

inherit elisp

MY_P="${PN}-el-${PV}"

DESCRIPTION="mldonkey.el is an Emacs Lisp interface to the MLDonkey core"
HOMEPAGE="http://www.physik.fu-berlin.de/~dhansen/mldonkey/"
SRC_URI="http://www.physik.fu-berlin.de/%7Edhansen/mldonkey/files/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc-macos"
IUSE=""

S=${WORKDIR}/${MY_P}

SITEFILE=50mldonkey-gentoo.el

src_compile() {
	elisp-comp ml*.el
}

pkg_postinst() {
	elisp-site-regen
	ewarn
	ewarn "If your network gets really slow when you use mldonkey,"
	ewarn "consider reducing the max number of connections. See bug #50510."
	ewarn
}
