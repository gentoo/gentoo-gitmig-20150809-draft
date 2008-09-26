# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/pandodl/pandodl-0.9.2.0.ebuild,v 1.3 2008/09/26 17:42:30 zmedico Exp $

inherit eutils

DESCRIPTION="Downloader client for the Pando torrent-like P2P system"
HOMEPAGE="http://www.pando.com/"
SRC_URI="http://www.pando.com/dl/download/${P}.tar.bz2
	mirror://gentoo/pandolibs-0.tgz"

LICENSE="Pando-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
PROPERTIES="interactive"
RESTRICT="strip"

DEPEND=""
RDEPEND="
	x86? (
		sys-libs/libstdc++-v3
		>=x11-libs/gtk+-2.6
		x11-libs/libXinerama
		)
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-xlibs
		)"
# >=dev-libs/expat-2.0.0: shipped with pandolibs tarball.
# Probably pandolibs shouldn't depend on libXinerama, #207880

S=${WORKDIR}/${PN}

pkg_setup() {
	check_license
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv pandolibs/* pandodl/lib/
	cd "${S}"
}

src_install() {
	insinto /opt/${PN}
	doins -r lib *.png || die

	exeinto /opt/${PN}/bin
	doexe bin/pandoDownloader || die

	dobin "${FILESDIR}"/${PN} || die

	dodoc README

	newicon pando_icon48.png ${PN}.png || die
	make_desktop_entry ${PN} "Pando Linux Downloader" ${PN} "Network;P2P;"
}
