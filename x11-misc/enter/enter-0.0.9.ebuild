# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/enter/enter-0.0.9.ebuild,v 1.1 2010/06/20 21:22:49 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="A lightweight graphical login manager for X"
HOMEPAGE="http://enter.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXau
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libX11
	media-libs/imlib2"
DEPEND="${RDEPEND}
	>=media-libs/freetype-2
	x11-proto/xproto"

src_prepare() {
	sed -i \
		-e 's:enter_LDFLAGS:enter_LDADD:' \
		src/Makefile.am || die

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
