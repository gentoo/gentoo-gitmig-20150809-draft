# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snmpmon/snmpmon-0.5.ebuild,v 1.1 2004/07/24 12:33:06 eldad Exp $

IUSE=""

inherit kde-functions

need-qt 3.2

DESCRIPTION="SNMPMonitor is a tool to monitor SNMP devices"
HOMEPAGE="http://snmpmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/snmpmon/${P}.tar.bz2"
RESTRICT="nomirror"
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=net-analyzer/net-snmp-5.0.9-r1"

src_compile() {
	qmake -o Makefile snmpmon.pro
	sed -i -e "s/CFLAGS   = -pipe -w -O2/CFLAGS   = ${CFLAGS} -w/" Makefile
	sed -i -e "s/CXXFLAGS = -pipe -w -O2/CXXFLAGS = ${CXXFLAGS} -w/" Makefile
	addpredict ${QTDIR}/etc/settings
	emake || die "make failed"
}

src_install () {
	export INSTALL_ROOT=${D}
	emake install || die "make install failed"
	cp oid.map example.mon ${D}/usr/share/snmpmon/
	dodoc COPYING README
}

pkg_postinst() {
	einfo
	einfo "Every user of SNMPMonitor has to copy the file oid.map:"
	einfo "mkdir ~/.snmpmon ; cp /usr/share/snmpmon/oid.map ~/.snmpmon"
	einfo
}
