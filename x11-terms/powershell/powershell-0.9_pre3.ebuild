# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-terms/powershell/powershell-0.9_pre3.ebuild,v 1.1 2002/09/15 06:56:01 mkennedy Exp $

S=${WORKDIR}/${P/_pre*/}
DESCRIPTION="Terminal emulator, supports multiple terminals in a single window"
SRC_URI="http://powershell.pdq.net/download/${PN}-pre${PV/_pre*/}-${PV/*pre/}.tar.gz"
HOMEPAGE="http://powershell.pdq.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"
RDEPEND="${DEPEND}"

src_compile() { 
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc
	assert
  
	emake || die
}

src_install() { 
	dodir /usr/share/gnome/apps/Utilities
	make prefix=${D}/usr install || die
	
	dodoc AUTHORS BUGS COPYING README
}
