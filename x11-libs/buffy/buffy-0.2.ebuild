# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/buffy/buffy-0.2.ebuild,v 1.6 2002/07/22 13:57:40 aliz Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GTK+ theme engine"

SRC_URI="http://reality.sgi.com/offer/src/buffy/${P}.tar.gz"

HOMEPAGE="http://reality.sgi.com/offer/src/buffy/"
LICENSE="X11"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc 
        =x11-libs/gtk+-1.2*"

src_compile() {
	./configure --infodir=/usr/share/info \
	--mandir=/usr/share/man \
	--prefix=/usr \
	--host=${CHOST} || die

	emake || die
}

src_install () {
	# try make prefix=${D}/usr install

	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
	try make DESTDIR=${D} install
}

