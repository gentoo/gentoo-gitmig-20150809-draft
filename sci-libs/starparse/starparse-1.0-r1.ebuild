# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/starparse/starparse-1.0-r1.ebuild,v 1.2 2012/05/04 08:22:52 jdhore Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Library for parsing NMR star files (peak-list format) and CIF files"
HOMEPAGE="http://burrow-owl.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
# Created from rev 19 @ http://oregonstate.edu/~benisong/software/projects/starparse/releases/1.0
SRC_URI="http://dev.gentooexperimental.org/~jlec/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="guile"

RDEPEND="guile? ( dev-scheme/guile )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-guile1.8.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable guile)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

src_test() {
	if use guile; then
		emake check || die
	else
		ewarn "Skipping tests because USE guile is disabled"
	fi
}
