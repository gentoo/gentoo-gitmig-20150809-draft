# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-sid/xmms-sid-0.7.3.ebuild,v 1.2 2002/07/22 00:48:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C64 SID plugin for XMMS"
HOMEPAGE="http://www.tnsp.org/xmms-sid.php"
SRC_URI="http://www.tnsp.org/xs-files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL README* NEWS TODO
}
