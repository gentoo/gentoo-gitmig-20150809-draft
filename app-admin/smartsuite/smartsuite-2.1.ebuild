# Copyright 2002 Gentoo Technologies, Inc
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/smartsuite/smartsuite-2.1.ebuild,v 1.3 2002/07/30 04:01:11 cselkirk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Suite to control and monitor storage devices using SMART technology."
HOMEPAGE="http://www.linux-ide.org/smart.html"
SRC_URI="mirror://sourceforge/smartsuite/${P}.tar.gz
	http://www.linux-ide.org/smart/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

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
