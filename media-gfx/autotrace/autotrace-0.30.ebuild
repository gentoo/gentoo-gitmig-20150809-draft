# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.30.ebuild,v 1.1 2002/05/25 08:37:05 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Converts Bitmaps to vector-grahics"
SRC_URI="http://ftp1.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://autotrace.sourceforge.net/"

DEPEND="virtual/glibc
	>=x11-libs/gtkDPS-0.3.3
	>=x11-libs/gtk+-1.2.10-r4"
RDEPEND=${DEPEND}

LICENSE="GPL-2"

src_compile() {

	./configure --host=${CHOST} \
		--prefix=/usr || die
		    
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING ChangeLog NEWS README 
}

