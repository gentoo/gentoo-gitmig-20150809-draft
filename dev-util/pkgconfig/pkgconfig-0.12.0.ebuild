# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.12.0.ebuild,v 1.12 2003/09/06 08:39:23 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Package Config system that manages compile/link flags for libraries"
SRC_URI="http://www.freedesktop.org/software/pkgconfig/releases/${P}.tar.gz"
HOMEPAGE="http://www.freedesktop.org/software/pkgconfig/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc"
RDEPEND=""

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man
	assert

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
