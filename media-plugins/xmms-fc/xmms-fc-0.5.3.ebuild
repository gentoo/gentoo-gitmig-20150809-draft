# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-fc/xmms-fc-0.5.3.ebuild,v 1.5 2004/04/17 16:22:03 eradicator Exp $

DESCRIPTION="Amiga Future Composer plug-in for XMMS"
HOMEPAGE="http://xmms-fc.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-fc/${P}.tar.bz2"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

IUSE=""
DEPEND="media-sound/xmms"

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog INSTALL README
}
