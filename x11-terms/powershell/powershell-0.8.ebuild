# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/powershell/powershell-0.8.ebuild,v 1.1 2001/10/07 09:23:40 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Terminal emulator, supports multiple terminals in a single window"
SRC_URI="http://powershell.pdq.net/download/${P}.tar.gz"
HOMEPAGE="http://powershell.pdq.net"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() { 
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc
	assert
  
	emake || die
}

src_install() { 
	make prefix=${D}/usr install || die
	
	dodoc AUTHORS BUGS COPYING README
}
