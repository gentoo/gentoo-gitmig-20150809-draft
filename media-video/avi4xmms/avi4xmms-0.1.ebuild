# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/media-video/avi4xmms/avi4xmms-0.1.ebuild,v 1.3 2002/05/23 06:50:14 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A plugin for XMMS to play AVI/DivX/ASF movies"
SRC_URI="http://prdownloads.sourceforge.net/my-xmms-plugs/${P}.tar.gz"
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

