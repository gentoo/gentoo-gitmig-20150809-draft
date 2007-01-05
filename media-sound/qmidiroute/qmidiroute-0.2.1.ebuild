# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmidiroute/qmidiroute-0.2.1.ebuild,v 1.2 2007/01/05 17:47:03 flameeyes Exp $

IUSE=""

inherit eutils qt3

DESCRIPTION="QMidiRoute is a filter/router for MIDI events."
HOMEPAGE="http://alsamodular.sourceforge.net"
SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="$(qt_min_version 3.2)
	>=media-libs/alsa-lib-0.9.0
	x11-libs/libX11"

src_unpack() {
	unpack ${A}
#	sed -i -e 's:QT_BASE_DIR=/usr/lib/qt3:QT_BASE_DIR=/usr/qt/3:' ${S}/make_qmidiroute || die "	sed failed"
	cd ${S}
	epatch ${FILESDIR}/${P}-fixqtbasedir.patch
	sed -i -e "s:^\(CXXFLAGS\)\(.*\):\1+\2:"  -e 's:gcc:$(CXX):g' make_qmidiroute
}

src_compile() {
	make -f make_qmidiroute || die "make QMidiRoute failed"
}

src_install() {
	dobin qmidiroute || die "install binaries failed"
	dodoc README LICENSE || die "install doc failed"
	insinto /usr/share/${PN}
	doins aeolus01.qmr
}

pkg_postinstall() {
	elog ""
	elog "You will find an example of MIDI filter configuration for use"
	elog "with aeolus in /usr/share/${PN}"
	elog ""
}
