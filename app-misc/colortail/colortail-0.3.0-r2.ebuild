# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colortail/colortail-0.3.0-r2.ebuild,v 1.9 2004/02/09 07:31:55 absinthe Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Colortail custom colors your log files and works like tail"
SRC_URI="http://www.student.hk-r.se/~pt98jan/colortail-0.3.0.tar.gz"
HOMEPAGE="http://www.student.hk-r.se/~pt98jan/colortail.html"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gcc3.patch || die "Patching failed"
}

src_compile() {
	./configure --prefix=/usr --host=${CHOST}
	make || die
}

src_install()  {

	make DESTDIR=${D} install || die
	dodoc README example-conf/conf*
	dodir /usr/bin/wrappers
	dosym /usr/bin/colortail /usr/bin/wrappers/tail
}

pkg_postinst() {
	einfo
	if grep /usr/bin/wrappers /etc/profile > /dev/null
	then
		einfo "/etc/profile already updated for wrappers"
	else
		einfo "Add this to the end of your ${ROOT}etc/profile:"
		einfo
		einfo "#Put /usr/bin/wrappers in path before /usr/bin"
		einfo 'export PATH=/usr/bin/wrappers:${PATH}'
	fi
	einfo
}
