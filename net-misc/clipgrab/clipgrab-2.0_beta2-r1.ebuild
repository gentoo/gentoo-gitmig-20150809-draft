# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clipgrab/clipgrab-2.0_beta2-r1.ebuild,v 1.1 2009/06/21 12:31:32 billie Exp $

EAPI=1
inherit eutils qt4 versionator

MY_PV=$(replace_version_separator 2 '-' )

DESCRIPTION="Download from various internet video services like Youtube etc."
HOMEPAGE="http://clipgrab.de"
SRC_URI="http://${PN}.de/download/${PN}-${MY_PV}_src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="x11-misc/xdg-utils
		media-video/ffmpeg
		${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	use debug || echo -e "\nDEFINES += QT_NO_DEBUG_OUTPUT" >> src.pro
}

src_compile() {
	cd "${S}"/src
	eqmake4 src.pro
	emake || die "emake failed"
}

src_install() {
	# upstream's Makefile has no install target :(
	cd "${S}"
	dobin bin/clipgrab || die "dobin failed"
	dodoc src/README || die "dodoc failed"

	insinto /usr/share/pixmaps
	newins src/img/icon.png clipgrab.png
	make_desktop_entry clipgrab Clipgrab "" "Qt;Video;AudioVideo"
}

# vim:ts=4
