# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/buffy/buffy-0.2.ebuild,v 1.10 2003/02/13 16:54:50 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ theme engine"
SRC_URI="http://reality.sgi.com/offer/src/buffy/${P}.tar.gz"
HOMEPAGE="http://reality.sgi.com/offer/src/buffy/"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86 sparc "

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
