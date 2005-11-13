# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gtkfxp/gtkfxp-0.5.ebuild,v 1.1 2005/11/13 06:59:18 vapier Exp $

inherit eutils

DESCRIPTION="FXP client written in GTK"
HOMEPAGE="http://home.swipnet.se/~w-92416/gtkfxp/"
SRC_URI="http://home.swipnet.se/~w-92416/gtkfxp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc BUGS ChangeLog README TODO
}
