# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-0.83.ebuild,v 1.2 2003/04/30 00:06:12 vapier Exp $

DESCRIPTION="modular and portable cryptographic toolkit"
HOMEPAGE="http://libtomcrypt.org/"
SRC_URI="http://libtomcrypt.org/files/crypt-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"

DEPEND="app-text/tetex"

src_compile() {
	emake || die
}

src_install() {
	cp makefile{,.old}
	sed -e 's:mpi.h:tommath.h:' makefile.old > makefile
	make DESTDIR=${D} install || die
}
