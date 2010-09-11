# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fireflies/fireflies-2.07-r1.ebuild,v 1.1 2010/09/11 14:55:15 xarthisius Exp $

EAPI=2

inherit autotools eutils multilib

DESCRIPTION="Fireflies screensaver: Wicked cool eye candy"
HOMEPAGE="http://somewhere.fscked.org/proj/fireflies/"
SRC_URI="http://somewhere.fscked.org/proj/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/mesa
	media-libs/libsdl
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	tar xzf libgfx-1.0.1.tar.gz
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build_system.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-gcc44.patch
	eautoreconf
}

src_configure() {
	econf --with-confdir=/usr/share/xscreensaver/config \
		--with-bindir=/usr/$(get_libdir)/misc/xscreensaver
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README TODO || die
}
