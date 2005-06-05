# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-morestate/xmms-morestate-1.2.ebuild,v 1.8 2005/06/05 15:54:31 luckyduck Exp $

inherit eutils

DESCRIPTION=" XMMS Morestate restores ESD volume, song time, and playing/paused status"
SRC_URI="mirror://sourceforge/xmms-morestate/${P}.tar.gz"
HOMEPAGE="http://xmms-morestate.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc sparc"
IUSE=""

RESTRICT="primaryuri"

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
