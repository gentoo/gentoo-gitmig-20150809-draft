# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-jess/xmms-jess-2.9.1.ebuild,v 1.1 2002/06/03 21:25:42 lostlogic Exp $

NAME="JESS"
S=${WORKDIR}/${NAME}-${PV}
DESCRIPTION="JESS Visualization Plugin for XMMS"
SRC_URI="http://arquier.free.fr/${NAME}-${PV}.tar.gz"
HOMEPAGE="http://arquier.free.fr/"

LICENSE="GPL"
SLOT="0"

DEPEND=">=media-sound/xmms-1.2.5
	>=media-libs/libsdl-1.1.5
	>=x11-base/xfree-3.3.6"
RDEPEND="${DEPEND}"

src_compile() {

	econf || die
	emake || die
}


src_install () {

	dodir /usr/lib/xmms/Visualization

	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
