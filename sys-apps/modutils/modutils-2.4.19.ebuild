# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.19.ebuild,v 1.2 2002/09/14 15:51:25 bjb Exp $

SLOT="0"
DESCRIPTION="Standard kernel module utilities"
SRC_URI="http://www.kernel.org/pub/linux/utils/kernel/modutils/v2.4/${P}.tar.bz2"
HOMEPAGE=""
KEYWORDS="x86 ppc sparc sparc64 alpha"
LICENSE="GPL-2"
DEPEND="virtual/glibc"

src_compile() {
	myconf=""
	# see bug #3897 ... we need insmod static, as libz.so is in /usr/lib
	#
	# Final resolution ... dont make it link against zlib, as the static
	# version do not want to autoload modules :(
	myconf="${myconf} --disable-zlib"

	./configure --prefix=/ \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--disable-strip \
		--enable-insmod-static \
		${myconf} || die "./configure failed"
		
	emake || die "emake failed"
}

src_install() {
	make prefix=${D} \
		mandir=${D}/usr/share/man \
		install || die "make install failed"

	dodoc COPYING CREDITS ChangeLog NEWS README TODO
}

