# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2vnc/x2vnc-1.5.1.ebuild,v 1.3 2003/05/15 17:54:10 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Control a remote computer running VNC from X"
SRC_URI="http://www.hubbe.net/~hubbe/${P}.tar.gz"
HOMEPAGE="http://www.hubbe.net/~hubbe/x2vnc.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha"

DEPEND="virtual/x11"
IUSE=""

src_compile() {

	xmkmf || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die

}


