# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-1.6.3.ebuild,v 1.12 2003/09/05 22:01:48 msterret Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An agent/software robot and a high level policy language for
building expert systems to administrate and configure large computer
networks"

SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${A}"
HOMEPAGE="http://www.iu.hio.no/cfengine/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND=">=sys-libs/glibc-2.1.3
	>=app-text/tetex-1.0.7-r2"

src_compile() {
	cd ${S}
	try ./configure

	try make
}

src_install () {
	cd ${S}
	try make DESTDIR=${D} install
	try make DESTDIR=${D}/doc install
	dodoc COPYING ChangeLog README
}
