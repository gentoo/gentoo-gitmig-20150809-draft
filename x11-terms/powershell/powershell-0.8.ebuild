# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/powershell/powershell-0.8.ebuild,v 1.5 2002/10/04 06:46:40 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Terminal emulator, supports multiple terminals in a single window"
SRC_URI="http://powershell.pdq.net/download/${P}.tar.gz"
HOMEPAGE="http://powershell.pdq.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

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
