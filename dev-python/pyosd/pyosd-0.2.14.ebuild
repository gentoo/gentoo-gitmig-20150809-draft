# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyosd/pyosd-0.2.14.ebuild,v 1.5 2007/04/21 09:12:34 dev-zero Exp $

inherit distutils

DESCRIPTION="PyOSD is a python module for displaying text on your X display, much like the 'On Screen Displays' used on TVs and some monitors."
HOMEPAGE="http://repose.cx/pyosd/"
SRC_URI="http://repose.cx/pyosd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="examples"

DEPEND=">=x11-libs/xosd-2.2.4"
RDEPEND="${DEPEND}"

src_install() {
	DOCS="AUTHORS"
	distutils_src_install
	dohtml pyosd.html

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r modules
	fi
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
