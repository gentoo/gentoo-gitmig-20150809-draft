# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2vnc/x2vnc-1.3.1.ebuild,v 1.5 2004/06/24 22:36:47 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Control a remote computer running VNC from X"
SRC_URI="http://www.hubbe.net/~hubbe/${PN}-1.31.tar.gz"
HOMEPAGE="http://www.hubbe.net/~hubbe/x2vnc.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11"

S="${WORKDIR}/x2vnc-1.31"

src_compile() {

	xmkmf || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die

}


