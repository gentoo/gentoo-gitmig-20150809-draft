# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: foser <foser@sesmar.eu.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-iris/xmms-iris-0.10.ebuild,v 1.2 2002/05/23 06:50:14 seemant Exp $

NAME="iris"
S=${WORKDIR}/${NAME}-${PV}
DESCRIPTION="XMMS OpenGL visualization plugin"
SRC_URI="http://cdelfosse.free.fr/xmms-iris/${NAME}-${PV}.tar.gz"
HOMEPAGE="http://cdelfosse.free.fr/xmms-iris/"

DEPEND="virtual/opengl
	=x11-libs/gtk+-1.2*
	>=media-sound/xmms-1.2.6-r1"

src_compile() {

	econf || die
	emake || die
}


src_install () {

	dodir /usr/lib/xmms/Visualization

	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO NEWS
}
