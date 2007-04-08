# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libprojectm/libprojectm-0.99-r1.ebuild,v 1.2 2007/04/08 21:58:50 chainsaw Exp $

inherit eutils autotools

MY_PN="${PN/libprojectm/libprojectM}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://xmms-projectm.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-projectm/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ppc ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="media-libs/ftgl
	media-libs/freetype
	virtual/opengl
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-fbsd.patch"
	AT_M4DIR="m4" eautoreconf || die "eautoreconf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
