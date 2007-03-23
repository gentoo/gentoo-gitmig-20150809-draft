# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mumble/mumble-0.9.4.ebuild,v 1.5 2007/03/23 14:51:45 drizzt Exp $

inherit eutils toolchain-funcs

DESCRIPTION="voice chat software for gaming written in Qt4"
HOMEPAGE="http://mumble.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="pch"

DEPEND="dev-libs/boost
	=x11-libs/qt-4*
	>=media-libs/speex-1.1.12
	media-libs/alsa-lib
	x11-libs/libXevie"

RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use -o =x11-libs/qt-4* sqlite sqlite3; then
		echo
		ewarn "You need to build Qt4 with the sqlite and/or sqlite3 use flag"
		echo
		die "Your Qt4 has no sqlite support"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	use pch || sed -i -e '3s: precompile_header$::' mumble.pri
	epatch "${FILESDIR}"/${P}-path.patch
}

src_compile() {
	qmake mumble.pro 	|| die "qmake failed"
	lrelease mumble.pro	|| die "mumble translation failed"
	emake CC="$(tc-getCC) ${CFLAGS}" \
		CXX="$(tc-getCXX) ${CXXFLAGS}" \
		LINK="$(tc-getCXX)" \
		LFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dodoc README CHANGES	|| die "installing docs failed"
	dobin mumble		|| die "installing failed"
	insinto /usr/share/pixmaps
	newins mumble.png.0 mumble.png \
		|| die "installing icon failed"
	make_desktop_entry mumble "Mumble" mumble.png "KDE;Qt;AudioVideo" \
		|| die "installing desktop entry failed"
}
