# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/runset/runset-1.4.ebuild,v 1.9 2002/10/04 03:45:33 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Runset Init suite, a replacement for sysv style initd"
SRC_URI="ftp://ftp.ocis.net/pub/users/ldeutsch/release/${P}.tar.gz"
HOMEPAGE="http://www.icewalkers.com/softlib/app/app_00233.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {

	econf || die
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
