# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/buffy/buffy-0.2-r1.ebuild,v 1.8 2002/10/04 06:38:32 vapier Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ theme engine"
SRC_URI="http://reality.sgi.com/offer/src/buffy/${P}.tar.gz"
HOMEPAGE="http://reality.sgi.com/offer/src/buffy/"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86 sparc sparc64"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	elibtoolize
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die 
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
