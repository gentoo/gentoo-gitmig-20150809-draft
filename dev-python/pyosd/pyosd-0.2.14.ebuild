# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyosd/pyosd-0.2.14.ebuild,v 1.2 2006/04/01 18:47:28 agriffis Exp $

inherit distutils

DESCRIPTION="PyOSD is a python module for displaying text on your X display, much like the 'On Screen Displays' used on TVs and some monitors."
HOMEPAGE="http://repose.cx/pyosd/"
SRC_URI="http://repose.cx/pyosd/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~x86"

DEPEND="virtual/python
	>=x11-libs/xosd-2.2.4"

src_install() {
	distutils_src_install
	dohtml pyosd.html
	dodoc AUTHORS
	cp -r modules ${D}/usr/share/doc/${PF}
}

pkg_postinst() {
	einfo ""
	einfo "If you want to run the included daemon"
	einfo "you will need to emerge dev-python/twisted."
	einfo ""
	einfo "Also note that the volume plugin"
	einfo "requires media-sound/aumix."
	einfo ""
}
