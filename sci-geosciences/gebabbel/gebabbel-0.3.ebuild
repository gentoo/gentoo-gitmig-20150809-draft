# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gebabbel/gebabbel-0.3.ebuild,v 1.1 2007/09/06 19:25:53 hanno Exp $

inherit eutils

DESCRIPTION="QT-Frontend to load and convert gps tracks with gpsbabel"
HOMEPAGE="http://gebabbel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Gebabbel-${PV}-Src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=x11-libs/qt-4.3.0
	sci-geosciences/gpsbabel"

S="${WORKDIR}/Gebabbel-${PV}"

pkg_setup() {
	if ! built_with_use 'x11-libs/qt' 'accessibility'; then
		eerror "You must build qt with accessibility support"
		die "x11-libs/qt built without accessibility"
	fi
}

src_unpack() {
	unpack "${A}" || die
	cd "${S}"
	epatch "${FILESDIR}/${P}-fix.diff"
}

src_compile() {
	qmake || die
	emake || die
}

src_install() {
	dobin bin/gebabbel || die
	dodoc CHANGELOG || die
}
