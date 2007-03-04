# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyosd/pyosd-0.2.14.ebuild,v 1.4 2007/03/04 09:32:10 lucass Exp $

inherit distutils

DESCRIPTION="PyOSD is a python module for displaying text on your X display, much like the 'On Screen Displays' used on TVs and some monitors."
HOMEPAGE="http://repose.cx/pyosd/"
SRC_URI="http://repose.cx/pyosd/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

DEPEND=">=x11-libs/xosd-2.2.4"

src_install() {
	distutils_src_install
	dohtml pyosd.html
	dodoc AUTHORS
	docinto modules
	dodoc modules/*
}

pkg_postinst() {
	elog ""
	elog "If you want to run the included daemon"
	elog "you will need to emerge dev-python/twisted."
	elog ""
	elog "Also note that the volume plugin"
	elog "requires media-sound/aumix."
	elog ""
}
