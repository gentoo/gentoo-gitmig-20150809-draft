# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/varconf/varconf-0.5.0.ebuild,v 1.1 2002/04/07 22:18:10 verwilst Exp $

S="${WORKDIR}/${P}"
SRC_URI="ftp://victor.worldforge.org/pub/worldforge/libs/varconf/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.net"
SLOT="0"
DEPEND="virtual/glibc"

src_compile() {

	./configure --host=${CHOST} --prefix=/usr || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

}
