# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/runset/runset-1.5.ebuild,v 1.1 2003/05/25 13:59:49 mholzer Exp $

DESCRIPTION="Runset Init suite, a replacement for sysv style initd"
SRC_URI="ftp://ftp.ocis.net/pub/users/ldeutsch/release/${P}.tar.gz"
HOMEPAGE="http://www.icewalkers.com/softlib/app/app_00233.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND="virtual/glibc"

src_compile() {
	econf
	make || die
}

src_install() {
	# fix info file
	echo "INFO-DIR-SECTION Admin" >>doc/runset.info
	echo "START-INFO-DIR-ENTRY" >>doc/runset.info
	echo "* runset: (runset). " >>doc/runset.info
	echo "END-INFO-DIR-ENTRY" >>doc/runset.info

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL ChangeLog LSM NEWS README
	cp -a ${S}/sample ${D}/usr/share/doc/${PF}
}
