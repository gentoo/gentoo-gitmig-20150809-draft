# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/buffy/buffy-0.2-r1.ebuild,v 1.5 2002/08/01 11:40:16 seemant Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GTK+ theme engine"

SRC_URI="http://reality.sgi.com/offer/src/buffy/${P}.tar.gz"

HOMEPAGE="http://reality.sgi.com/offer/src/buffy/"
LICENSE="X11"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc 
        =x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}

	cd ${S}
	libtoolize --force --copy
}

src_compile() {
	./configure 	--host=${CHOST} \
			--prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info
	assert
                    
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die 

	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}


