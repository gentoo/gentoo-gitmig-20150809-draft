# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fireflies/fireflies-2.07.ebuild,v 1.5 2008/03/27 10:25:55 drac Exp $

inherit eutils multilib

DESCRIPTION="Fireflies screensaver: Wicked cool eye candy"
HOMEPAGE="http://somewhere.fscked.org/fireflies/"
SRC_URI="http://somewhere.fscked.org/fireflies/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/mesa
	media-libs/libsdl
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.06-configure.patch
	epatch "${FILESDIR}"/${PN}-2.06-Make.include.in.patch
	sed -i -e 's:strip:true:' src/Makefile
}

src_compile() {
	econf --with-confdir=/usr/share/xscreensaver/config \
		--with-bindir=/usr/$(get_libdir)/misc/xscreensaver
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README TODO
}
