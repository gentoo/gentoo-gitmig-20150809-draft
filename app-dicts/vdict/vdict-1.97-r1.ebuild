# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict/vdict-1.97-r1.ebuild,v 1.3 2009/07/27 15:36:08 flameeyes Exp $

EAPI=1

inherit eutils

DESCRIPTION="Vdict - Vietnamese Dictionary"
SRC_URI="http://xvnkb.sourceforge.net/vdict/${P}.tar.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt:3
	sys-libs/gdbm
	media-libs/freetype"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-intptr_t.patch"
}

src_compile() {
	# bug #279334
	emake -j1 CC="$(tc-getCC)" CPP="$(tc-getCC) -E" CXX="$(tc-getCXX)" CXXPP="$(tc-getCC) -E" || die
}

src_install() {
	dobin fd/fd vd/vd utils/wd2vd || die

	dodoc AUTHORS BUGS ChangeLog README TODO || die
}

pkg_postinst() {
	elog "You may want to install app-dicts/vdict-* packages"
	elog "to have corresponding dictionaries"
}
