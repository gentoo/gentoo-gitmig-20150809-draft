# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-1.6.3.ebuild,v 1.13 2003/09/08 06:43:56 vapier Exp $

DESCRIPTION="agent/software robot and a high level policy language for building expert systems to administrate and configure large computer networks"
HOMEPAGE="http://www.iu.hio.no/cfengine/"
SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND=">=sys-libs/glibc-2.1.3
	>=app-text/tetex-1.0.7-r2"

src_compile() {
	./configure || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog README
}
