# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcdproc/lcdproc-0.4.1-r1.ebuild,v 1.14 2003/09/05 12:10:36 msterret Exp $

DESCRIPTION="lcdproc - displays system status on Matrix-Orbital 20x4 LCD on a serial port."
SRC_URI="http://lcdproc.omnipotent.net/${P}.tar.gz"
HOMEPAGE="http://lcdproc.omnipotent.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-apps/baselayout-1.6.4"

src_compile() {
	econf
	make || die
}

src_install() {
	exeinto /usr/local/bin
	doexe server/LCDd
	doexe clients/lcdproc/lcdproc
	doman docs/lcdproc.1
	dodoc README ChangeLog COPYING INSTALL
	docinto docs
	dodoc docs/README.dg* docs/*.txt
	docinto clients/example
	dodoc clients/examples/*.pl
	docinto clients/headlines
	dodoc clients/headlines/lcdheadlines

	# init.d & conf.d installation
	exeinto /etc/init.d
	doexe ${FILESDIR}/lcdproc
	insinto /etc/conf.d
	newins ${FILESDIR}/lcdproc.confd lcdproc
}
