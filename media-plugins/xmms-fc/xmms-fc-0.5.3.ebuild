# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-fc/xmms-fc-0.5.3.ebuild,v 1.8 2004/07/03 07:21:42 eradicator Exp $

inherit eutils

DESCRIPTION="Amiga Future Composer plug-in for XMMS"
HOMEPAGE="http://xmms-fc.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-fc/${P}.tar.bz2"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"

IUSE=""
DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/xmms-fc-gcc34.patch
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog INSTALL README
}
