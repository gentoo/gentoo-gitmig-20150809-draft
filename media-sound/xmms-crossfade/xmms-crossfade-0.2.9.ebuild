# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-crossfade/xmms-crossfade-0.2.9.ebuild,v 1.4 2002/07/22 00:48:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XMMS Plugin for crossfading, and continuous output."
SRC_URI="http://www.netcologne.de/~nc-eisenlpe2/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.netcologne.de/~nc-eisenlpe2/xmms-crossfade/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-sound/xmms-1.2.5-r1"

src_compile() {

	econf || die
	emake || die
}


src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}
