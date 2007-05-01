# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snmpmon/snmpmon-0.5.ebuild,v 1.7 2007/05/01 22:36:42 genone Exp $

inherit qt3

DESCRIPTION="SNMPMonitor is a tool to monitor SNMP devices"
HOMEPAGE="http://snmpmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/snmpmon/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~sparc x86"
IUSE=""

DEPEND="$(qt_min_version 3.2)
	>=net-analyzer/net-snmp-5.0.9-r1"

src_compile() {
	${QTDIR}/bin/qmake -o Makefile snmpmon.pro
	sed -i -e "s/CFLAGS   = -pipe -w -O2/CFLAGS   = ${CFLAGS} -w/" Makefile
	sed -i -e "s/CXXFLAGS = -pipe -w -O2/CXXFLAGS = ${CXXFLAGS} -w/" Makefile
	emake || die "make failed"
}

src_install () {
	export INSTALL_ROOT=${D}
	emake install || die "make install failed"
	cp oid.map example.mon ${D}/usr/share/snmpmon/
	dodoc COPYING README
}

pkg_postinst() {
	elog
	elog "Every user of SNMPMonitor has to copy the file oid.map:"
	elog "mkdir ~/.snmpmon ; cp /usr/share/snmpmon/oid.map ~/.snmpmon"
	elog
}
