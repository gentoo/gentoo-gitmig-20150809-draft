# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Terje Kvernes <terjekv@math.uio.no>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libggz/libggz-0.0.5.ebuild,v 1.3 2002/05/27 17:27:37 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="The GGZ library, used by GGZ Gameing Zone"

SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

HOMEPAGE="http://ggz.sourceforge.net/"

DEPEND=""

#RDEPEND=""

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
