# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdcss/libdvdcss-1.1.1-r1.ebuild,v 1.1 2002/05/22 19:47:08 azarah Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A portable abstraction library for DVD decryption"
SRC_URI="http://www.videolan.org/pub/videolan/libdvdcss/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.videolan.org/libdvdcss/"

DEPEND="virtual/glibc"


src_compile() {

	# Dont use custom optimiziations, as it gives problems
	# on some archs
	CFLAGS="" \
	CXXFLAGS="" \
	./configure --prefix=/usr \
		    --mandir=/usr/share/man \
		    --infodir=/usr/share/info ||die
		    
	make || die
}

src_install() {
	
	make prefix=${D}/usr \
	     mandir=${D}/usr/share/man \
	     infodir=${D}/usr/share/info \
	     install || die

	# 0.0.3.* and 1.0.0 compat
	dosym $(ls -l ${D}/usr/lib/libdvdcss.so | /usr/bin/gawk '{print $11}') \
		/usr/lib/libdvdcss.so.0
	dosym $(ls -l ${D}/usr/lib/libdvdcss.so | /usr/bin/gawk '{print $11}') \
		/usr/lib/libdvdcss.so.1

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

pkg_preinst() {

	# these could cause problems if they exist from
	# earlier builds
	for x in libdvdcss.so.0 libdvdcss.so.1
	do
		if [ -f /usr/lib/${x} ] || [ -L /usr/lib/${x} ]
		then
			rm -f /usr/lib/${x}
		fi
	done
}

