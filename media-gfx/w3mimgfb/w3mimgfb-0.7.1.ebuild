# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/w3mimgfb/w3mimgfb-0.7.1.ebuild,v 1.1 2003/06/16 15:03:14 phosphan Exp $

IUSE=""

DESCRIPTION="Image viewer for w3m under frame buffer environment"
SRC_URI="http://homepage3.nifty.com/slokar/fb/${P}.tar.gz"
HOMEPAGE="http://homepage3.nifty.com/slokar/fb/w3mimg.html"

SLOT="0"
LICENSE="w3m BSD"
KEYWORDS="~x86"

DEPEND=">=media-libs/stimg-0.1.0
	virtual/textbrowser"

src_compile() {
	emake CC="${CC}" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	if [ -d /usr/lib/w3m ] ; then
		exeinto /usr/lib/w3m
		doexe w3mimgdisplayfb
	fi
	if [ -d /usr/lib/w3m-m17n ] ; then
		exeinto /usr/lib/w3m-m17n
		doexe w3mimgdisplayfb
	fi

	dodoc COPYING readme.txt
}
