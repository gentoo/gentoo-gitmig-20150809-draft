# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ggz-client-libs/ggz-client-libs-0.0.5.ebuild,v 1.4 2002/07/11 06:30:20 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="The client libraries for GGZ Gaming Zone"

SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

HOMEPAGE="http://ggz.sourceforge.net/"

DEPEND=">=dev-libs/libggz-0.0.5
		dev-libs/expat"

#RDEPEND=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
