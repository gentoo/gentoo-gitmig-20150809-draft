# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snmptt/snmptt-0.9.ebuild,v 1.2 2004/07/17 10:13:43 dholm Exp $

MY_P=${P/-/_}

DESCRIPTION="SNMP Trap Translator"
RESTRICT="nomirror"
SRC_URI="mirror://sourceforge/snmptt/${MY_P}.tgz"
HOMEPAGE="http://www.snmptt.org/"

LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	echo "traphandler default /usr/sbin/snmptt" >examples/snmptrapd.conf.sample
}

src_install() {
	into /usr
	dosbin snmptt
	dosbin snmptthandler
	dosbin snmptt-net-snmp-test

	insinto /etc/snmp
	doins snmptt.ini
	doins examples/snmptt.conf.generic
	doins examples/snmptrapd.conf.sample

	dohtml docs/faqs.html docs/index.html docs/layout1.css docs/snmptt.html docs/snmpttconvert.html docs/snmpttconvertmib.html
}
