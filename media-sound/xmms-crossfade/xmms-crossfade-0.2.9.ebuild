# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-crossfade/xmms-crossfade-0.2.9.ebuild,v 1.3 2002/07/11 06:30:42 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XMMS Plugin for crossfading, and continuous output."
SRC_URI="http://www.netcologne.de/~nc-eisenlpe2/xmms-crossfade/${P}.tar.gz"
HOMEPAGE="http://www.netcologne.de/~nc-eisenlpe2/xmms-crossfade/"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
        >=media-sound/xmms-1.2.5-r1"

src_compile() {

	./configure --infodir=/usr/share/info	\
		    --mandir=/usr/share/man	\
		    --host=${CHOST} || die

	emake || die
}


src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}


