# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/read-edid/read-edid-1.4.1.ebuild,v 1.1 2002/06/18 21:11:40 rphillips Exp $

DESCRIPTION="Read edid is a program that can get information from a pnp monitor."
HOMEPAGE="http://john.fremlin.de/programs/linux/read-edid/index.html"
LICENSE=""
DEPEND=""
#RDEPEND=""
SRC_URI="http://john.fremlin.de/programs/linux/read-edid/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
