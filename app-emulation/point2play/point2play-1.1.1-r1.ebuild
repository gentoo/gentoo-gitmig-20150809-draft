# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/point2play/point2play-1.1.1-r1.ebuild,v 1.3 2004/02/20 06:08:34 mr_bones_ Exp $

MY_P=${PN}-small-${PV}
DESCRIPTION="graphical frontend for WineX"
HOMEPAGE="http://www.transgaming.com/"
SRC_URI="${MY_P}.tgz"

LICENSE="point2play"
SLOT="3"
KEYWORDS="x86"
RESTRICT="fetch"

RDEPEND="virtual/x11
	>=dev-lang/python-2.0
	>=dev-python/pygtk-1.99.16
	>=x11-themes/gtk-engines-metal-2.2.0"

pkg_nofetch() {
	einfo "Please download the appropriate Point2Play archive (${MY_P}.tgz)"
	einfo "from ${HOMEPAGE} (requires a Transgaming subscription)"
	echo
	einfo "The archive should then be placed into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-python2.2.patch
}

src_install() {
	mv ${WORKDIR}/usr ${D}
}
