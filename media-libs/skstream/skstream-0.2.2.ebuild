# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/skstream/skstream-0.2.2.ebuild,v 1.4 2002/08/14 13:08:10 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="FreeSockets - Portable C++ classes for IP (sockets) applications"
SRC_URI="ftp://victor.worldforge.org/pub/worldforge/libs/skstream/${P}.tar.gz"
HOMEPAGE="http://www.worldforge.org"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {

	econf || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
