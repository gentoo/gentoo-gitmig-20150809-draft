# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/dillo/dillo-0.6.4-r1.ebuild,v 1.2 2002/05/23 06:50:18 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Lean GTK+-based web browser"
SRC_URI="http://prdownloads.sourceforge.net/dillo/dillo-0.6.4.tar.gz"
HOMEPAGE="http://dillo.sf.net"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2.1"

RDEPEND="$DEPEND"

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

	dodoc AUTHORS COPYING ChangeLog ChangeLog.old INSTALL README NEWS

	docinto doc
	dodoc doc/*.txt doc/README

}
