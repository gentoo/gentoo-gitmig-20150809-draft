# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-1.3.ebuild,v 1.4 2002/04/16 01:14:04 seemant Exp $

S=${WORKDIR}/T1Lib-${PV}
DESCRIPTION="A Type 1 Rasterizer Library for UNIX/X11"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/libs/graphics/${P}.tar.gz"
HOMEPAGE="http://www.neuroinformatik.ruhr-uni-bochum.de/ini/PEOPLE/rmz/t1lib/t1lib.html"

DEPEND="X? ( virtual/x11 )
	tetex? ( >=app-text/tetex-1.0.7 )"

src_compile() {

	local myconf
	local myopt

	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"
	
	use tetex \
		|| myopt="without_doc"
	
	./configure  \
		--host=${CHOST} \
		--prefix=/usr \
		--datadir=/etc \
		${myconf} || die
	
	emake ${myopt} || die
}

src_install() {

	cd lib
	insinto /usr/include
	doins t1lib.h

	use X && ( \
		doins t1libx.h
		dolib .libs/libt1x.{la,a,so.1.3.0}
		dosym libt1x.so.1.3.0 /usr/lib/libt1x.so.1
		dosym libt1x.so.1.3.0 /usr/lib/libt1x.so
	)

	dolib .libs/libt1.{la,a,so.1.3.0}
	dosym libt1.so.1.3.0 /usr/lib/libt1.so.1
	dosym libt1.so.1.3.0 /usr/lib/libt1.so
	insinto /etc/t1lib
	doins t1lib.config

	cd ..
	dodoc Changes LGPL LICENSE README*

}
