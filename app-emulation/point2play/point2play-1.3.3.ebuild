# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/point2play/point2play-1.3.3.ebuild,v 1.4 2007/07/22 09:27:43 omp Exp $

inherit eutils

MY_P=${PN}-small-${PV}-1
DESCRIPTION="graphical frontend for WineX"
HOMEPAGE="http://www.transgaming.com/"
SRC_URI="${MY_P}.tgz"

LICENSE="point2play"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""
RESTRICT="fetch"

RDEPEND="x11-libs/libX11
	virtual/opengl
	>=dev-lang/python-2.3
	>=dev-python/pygtk-2.4"
	#>=x11-themes/gtk-engines-metal-2.2.0"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download the appropriate Point2Play archive (${MY_P}.tgz)"
	einfo "from ${HOMEPAGE} (requires a Transgaming subscription)"
	echo
	einfo "The archive should then be placed into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/1.3.2-fix-sound-test.patch
}

src_install() {
	mv usr "${D}"/ || die "mv usr"
	mv etc/X11/applnk "${D}"/usr/share
	make_desktop_entry Point2Play Point2Play /usr/lib/transgaming_point2play/pixmaps/tg_logo.png
}
