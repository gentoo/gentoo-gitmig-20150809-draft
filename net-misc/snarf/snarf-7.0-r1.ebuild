# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/snarf/snarf-7.0-r1.ebuild,v 1.9 2002/08/30 11:26:16 cybersystem Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A full featured small web-spider"
SRC_URI="http://www.xach.com/snarf/${P}.tar.gz"
HOMEPAGE="http://www.xach.com/snarf/"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {													 
	econf || die
	make || die
}

src_install() {															 
	into /usr
	dobin snarf
	doman snarf.1
	dodoc COPYING ChangeLog README TODO
}
