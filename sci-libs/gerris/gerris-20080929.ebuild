# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gerris/gerris-20080929.ebuild,v 1.4 2011/03/02 19:59:23 jlec Exp $

EAPI="1"

inherit autotools

DESCRIPTION="The Gerris Flow Solver"
LICENSE="GPL-2"
HOMEPAGE="http://gfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/gfs/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mpi dx"

RDEPEND="dev-libs/glib:2
		>=sci-libs/gts-20081607
		sys-apps/gawk
		dev-lang/python
		mpi? ( virtual/mpi )
		dx? ( sci-visualization/opendx )"
DEPEND="${RDEPEND}
		sys-devel/libtool"

RESTRICT="test"

S="${WORKDIR}"/${PN}-snapshot-080929

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-as-needed.patch
	eautoreconf
}

src_compile() {
	econf $(use_enable mpi ) \
		$(use_enable dx) \
		|| die "configure failed"

	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	insinto /usr/share/doc/${P}/examples
	rm -f doc/examples/*.pyc || die "Failed to remove python object"
	doins -r doc/examples/*
}
