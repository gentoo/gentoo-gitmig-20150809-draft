# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus/oroborus-2.0.4.ebuild,v 1.1 2001/08/26 03:16:20 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Yet another window manager"
SRC_URI="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/${A}"
HOMEPAGE="http://www.kensden.pwp.blueyonder.co.uk/Oroborus"


DEPEND="virtual/x11"


src_compile() {
	./configure --infodir=/usr/X11R6/info --mandir=/usr/X11R6/man   \
	            --prefix=/usr/X11R6 --host=${CHOST}  || die
	
	emake || die
}

src_install () {
	
	make DESTDIR=${D} install || die
	dodoc README INSTALL ChangeLog TODO NEWS AUTHORS example.oroborusrc
}

