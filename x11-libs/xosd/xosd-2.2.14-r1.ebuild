# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-2.2.14-r1.ebuild,v 1.4 2007/01/04 18:59:57 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

DESCRIPTION="Library for overlaying text/glyphs in X-Windows X-On-Screen-Display plus binary for sending text from command line"
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="mirror://debian/pool/main/x/xosd/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/xosd/${PN}_${PV}-1.diff.gz
	http://digilander.libero.it/dgp85/gentoo/${PN}-gentoo-m4-1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="xinerama"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libXext )
	virtual/x11 )"

DEPEND="|| ( (
	x11-libs/libX11
	x11-libs/libXt
	x11-proto/xextproto
	xinerama? ( x11-proto/xineramaproto )
	x11-proto/xproto )
	virtual/x11 )
	${RDEPEND}"

RESTRICT="confcache"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${DISTDIR}"/${PN}_${PV}-1.diff.gz

	AT_M4DIR="${WORKDIR}/m4" eautoreconf
}

src_compile() {
	econf \
		`use_enable xinerama` \
		--disable-new-xmms \
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS COPYING README TODO
}
