# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2vnc/x2vnc-1.5.1.ebuild,v 1.9 2004/07/15 00:56:41 agriffis Exp $

DESCRIPTION="Control a remote computer running VNC from X"
SRC_URI="http://www.hubbe.net/~hubbe/${P}.tar.gz"
HOMEPAGE="http://www.hubbe.net/~hubbe/x2vnc.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ~sparc"

DEPEND="virtual/x11"
IUSE=""

src_compile() {

	xmkmf || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die

}
