# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/worker/worker-2.3.1.ebuild,v 1.2 2002/07/11 06:30:17 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Worker Filemanager: Amiga Directory Opus 4 clone."

SRC_URI="http://www.boomerangsworld.de/worker/downloads/${P}.tar.bz2"

HOMEPAGE="http://www.boomerangsworld.de/worker"

DEPEND="virtual/x11"


src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "Parallel make failed"

}

src_install () {
 
	make DESTDIR=${D} install || die "Installation failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS

}
