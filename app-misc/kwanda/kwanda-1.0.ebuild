# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/kwanda/kwanda-1.0.ebuild,v 1.5 2002/07/25 17:20:02 seemant Exp $

inherit kde-base || die
S=${WORKDIR}/${PN}

need-kde 2.1
DESCRIPTION="KDE fish that lives in the taskbar :o)"
SRC_URI="http://kwanda.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://kwanda.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	
	cd ${S}
	make clean && rm -f config.cache
	kde_src_compile myconf
	CFLAGS="${CFLAGS} -I{KDE2DIR}/include"
	./configure ${myconf} || die

}
