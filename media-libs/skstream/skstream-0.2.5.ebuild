# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/skstream/skstream-0.2.5.ebuild,v 1.3 2004/03/19 07:56:05 mr_bones_ Exp $

S=${WORKDIR}/${P}
DESCRIPTION="FreeSockets - Portable C++ classes for IP (sockets) applications"
SRC_URI="ftp://victor.worldforge.org/pub/worldforge/libs/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.org"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "configure died"
	emake || die "make died"
}

src_install() {

	make DESTDIR=${D} install || die "make install died"

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
