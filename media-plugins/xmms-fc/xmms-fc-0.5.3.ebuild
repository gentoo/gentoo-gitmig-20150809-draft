# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-fc/xmms-fc-0.5.3.ebuild,v 1.1 2003/06/05 01:01:37 robh Exp $

DESCRIPTION="Amiga Future Composer plug-in for XMMS"
HOMEPAGE="http://xmms-fc.sourceforge.net/"
SRC_URI="http://switch.dl.sourceforge.net/sourceforge/xmms-fc/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""
DEPEND="media-sound/xmms"

src_compile() {
    econf || die "./configure failed"
    emake || die
}

src_install () {
    make DESTDIR=${D} install || die
    dodoc COPYING ChangeLog INSTALL README
}
