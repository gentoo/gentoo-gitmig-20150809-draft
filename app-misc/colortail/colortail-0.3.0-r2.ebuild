# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colortail/colortail-0.3.0-r2.ebuild,v 1.12 2004/06/28 03:30:17 vapier Exp $

inherit eutils

DESCRIPTION="Colortail custom colors your log files and works like tail"
HOMEPAGE="http://www.student.hk-r.se/~pt98jan/colortail.html"
SRC_URI="http://www.student.hk-r.se/~pt98jan/colortail-0.3.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.patch
}

src_compile() {
	./configure --prefix=/usr --host=${CHOST}
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README example-conf/conf*
	dodir /usr/bin/wrappers
	dosym /usr/bin/colortail /usr/bin/wrappers/tail
}

pkg_postinst() {
	if grep /usr/bin/wrappers ${ROOT}/etc/profile > /dev/null
	then
		einfo "/etc/profile already updated for wrappers"
	else
		einfo "Add this to the end of your ${ROOT}etc/profile:"
		einfo
		einfo "#Put /usr/bin/wrappers in path before /usr/bin"
		einfo 'export PATH=/usr/bin/wrappers:${PATH}'
	fi
}
