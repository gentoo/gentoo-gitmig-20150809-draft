# Copyright 2002 Alexander Gretencord <arutha@gmx.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/smartsuite/smartsuite-2.1.ebuild,v 1.1 2002/07/23 23:28:34 agenkin Exp $

DESCRIPTION="Suite to control and monitor storage devices using SMART technology."
HOMEPAGE="http://www.linux-ide.org/smart.html"
DEPEND="virtual/glibc"
LICENSE="GPL-2"

SRC_URI="mirror://sourceforge/smartsuite/${P}.tar.gz
	http://www.linux-ide.org/smart/${P}.tar.gz"
S=${WORKDIR}/${P}


src_unpack() {

	unpack ${A}
	cd ${S}
	sed -e "/^CFLAGS/ s/-O2/$CFLAGS/" < Makefile > Makefile.hacked
	mv Makefile.hacked Makefile

}

src_compile() {

	emake || die

}

src_install() {

	dosbin smartctl smartd
	doman smartctl.8 smartd.8

	insinto /etc/init.d
	newins ${FILESDIR}/smartd.rc smartd

	dodoc CHANGELOG TODO COPYING README

}
