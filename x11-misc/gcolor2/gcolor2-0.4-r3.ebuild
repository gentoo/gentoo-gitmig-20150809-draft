# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gcolor2/gcolor2-0.4-r3.ebuild,v 1.1 2008/01/08 09:11:39 remi Exp $

inherit eutils autotools

DESCRIPTION="A simple GTK+2 color selector."
HOMEPAGE="http://gcolor2.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/modular-rgb.patch"
	epatch "${FILESDIR}/${P}-amd64.patch"
	epatch "${FILESDIR}/${P}-pkg-config-macro.patch"
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc INSTALL AUTHORS
	make_desktop_entry gcolor2 gcolor2 /usr/share/pixmaps/gcolor2/icon.png Graphics
}
