# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/media-video/avi4xmms/avi4xmms-0.1.ebuild,v 1.4 2002/05/27 17:27:38 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A plugin for XMMS to play AVI/DivX/ASF movies"
SRC_URI="mirror://sourceforge/my-xmms-plugs/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/my-xmms-plugs/"

DEPEND="virtual/glibc
	>=media-video/avifile-0.6
	>=media-sound/xmms-1.2.7"

src_compile() {

    ./configure \
		--prefix=/usr \
		--host=${CHOST} || die

    emake || die
}

src_install () {

    make \
		libdir=/usr/lib/xmms/Input \
		DESTDIR=${D} install || die

    dodoc AUTHORS COPYING ChangeLog README TODO
}

