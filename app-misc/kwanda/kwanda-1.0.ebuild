# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kwanda/kwanda-1.0.ebuild,v 1.11 2003/09/05 12:10:36 msterret Exp $

inherit kde-base
S=${WORKDIR}/${PN}

need-kde 2.1
DESCRIPTION="KDE fish that lives in the taskbar :o)"
SRC_URI="http://kwanda.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://kwanda.sourceforge.net"


LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	cd ${S}
	make clean && rm -f config.cache
	kde_src_compile myconf
	CFLAGS="${CFLAGS} -I{KDEDIR}/include"
	./configure ${myconf} || die

}
