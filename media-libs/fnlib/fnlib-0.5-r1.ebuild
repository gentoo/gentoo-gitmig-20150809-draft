# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/fnlib/fnlib-0.5-r1.ebuild,v 1.2 2002/04/27 11:18:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Font Library"
SRC_URI="ftp://ftp.enlightenment.org/pub/enlightenment/enlightenment/libs/${P}.tar.gz"

DEPEND="virtual/glibc >=media-libs/imlib-1.9.8.1"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/fnlib || die
	make || die
}

src_install() {
	
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/fnlib \
		install || die

	dodoc AUTHORS ChangeLog COPYING* HACKING NEWS README
	dodoc doc/fontinfo.README

}
