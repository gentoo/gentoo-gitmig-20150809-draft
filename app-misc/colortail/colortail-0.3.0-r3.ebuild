# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colortail/colortail-0.3.0-r3.ebuild,v 1.13 2004/12/06 17:48:02 ka0ttic Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Colortail custom colors your log files and works like tail"
# bug 73512 - package doesn't seem to have a valid home page
HOMEPAGE="http://web.archive.org/web/20030411093805/www.student.hk-r.se/~pt98jan/colortail.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc amd64"

src_unpack() {
	unpack ${A}
	cd ${S}
	[ "`gcc-major-version`" == "3" ] && epatch ${FILESDIR}/${PV}/ansi-c++-gcc-3.2.diff
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README example-conf/conf*
	dodir /usr/bin/wrappers
	dosym /usr/bin/colortail /usr/bin/wrappers/tail
}

pkg_postinst() {
	einfo
	if grep /usr/bin/wrappers ${ROOT}/etc/profile > /dev/null
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
