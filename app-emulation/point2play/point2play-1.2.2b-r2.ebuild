# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/point2play/point2play-1.2.2b-r2.ebuild,v 1.2 2004/06/25 11:56:00 agriffis Exp $

inherit eutils

MY_P=${PN}-1.2.2.b
DESCRIPTION="graphical frontend for WineX"
HOMEPAGE="http://www.transgaming.com/"
SRC_URI="${MY_P}.tgz"

LICENSE="point2play"
SLOT="3"
KEYWORDS="x86"
IUSE=""
RESTRICT="fetch"

RDEPEND="virtual/x11
	>=dev-lang/python-2.3
	>=dev-python/pygtk-1.99.16
	>=x11-themes/gtk-engines-metal-2.2.0"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download the appropriate Point2Play archive (${MY_P}.tgz)"
	einfo "from ${HOMEPAGE} (requires a Transgaming subscription)"
	echo
	einfo "The archive should then be placed into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/1.2-python2.2.patch
}

src_install() {
	rm -rf \
		etc/X11/susewm \
		usr/lib/menu \
		usr/lib/transgaming_point2play/{bin,etc,lib}
	mv * ${D}
	dobin ${FILESDIR}/Point2Play
}
