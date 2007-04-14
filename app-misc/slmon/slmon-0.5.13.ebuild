# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/slmon/slmon-0.5.13.ebuild,v 1.2 2007/04/14 16:04:32 armin76 Exp $

inherit eutils

DESCRIPTION="Colored text-based system performance monitor"
HOMEPAGE="http://slmon.sourceforge.net/"
SRC_URI="http://slmon.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="debug"

DEPEND=">=dev-libs/glib-2.0"
RDEPEND="sys-libs/slang
	gnome-base/libgtop"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/${P}-invalid-free.patch # bug 151293
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
