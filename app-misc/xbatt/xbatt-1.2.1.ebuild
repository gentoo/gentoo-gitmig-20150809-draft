# Copyright 2001-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/xbatt/xbatt-1.2.1.ebuild,v 1.4 2002/07/25 19:18:35 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Notebook battery indicataor for X"
SRC_URI="http://www.clave.gr.jp/~eto/xbatt/${P}.tar.gz"
HOMEPAGE="http://www.clave.gr.jp/~eto/xbatt/"

SLOT="0"
LICENSE="as-is|BSD"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	make xbatt || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README* COPYRIGHT
}
