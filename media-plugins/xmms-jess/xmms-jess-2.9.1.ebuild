# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jess/xmms-jess-2.9.1.ebuild,v 1.5 2003/09/07 00:02:15 msterret Exp $

MY_P="JESS-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="JESS Visualization Plugin for XMMS"
SRC_URI="http://arquier.free.fr/${MY_P}.tar.gz"
HOMEPAGE="http://arquier.free.fr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	media-sound/xmms
	>=media-libs/libsdl-1.1.5"

src_compile() {

	econf || die
	emake || die
}


src_install () {

	dodir /usr/lib/xmms/Visualization

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
