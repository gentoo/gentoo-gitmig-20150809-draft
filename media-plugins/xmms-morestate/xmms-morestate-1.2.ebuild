# Copyright 1999-2004 Gentoo Foundation; alexf <acid DOT punk AT gmx DOT net>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-morestate/xmms-morestate-1.2.ebuild,v 1.7 2004/07/07 21:22:47 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION=" XMMS Morestate restores ESD volume, song time, and playing/paused status"
SRC_URI="mirror://sourceforge/xmms-morestate/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://xmms-morestate.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc sparc"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-Makefile.patch
}

src_install() {
	make DESTDIR=${D} install || die "Install failed."
	dodoc AUTHORS ChangeLog INSTALL README
}
