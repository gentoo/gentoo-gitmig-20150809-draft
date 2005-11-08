# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pykota/pykota-1.23_p1869-r1.ebuild,v 1.1 2005/11/08 11:07:01 satya Exp $

inherit python eutils distutils

DESCRIPTION="PyKota - Python print Quota for CUPS, LPRng and BSD printer servers"
SRC_URI="http://www.gentoo.org/~satya/packages/pykota/${P}.tar.bz2"
HOMEPAGE="http://www.librelogiciel.com/software/PyKota/Presentation/action_Presentation"
LICENSE="GPL-2"

IUSE="ldap postgres snmp xml xml2"

DEPEND="dev-lang/python
	dev-python/egenix-mx-base
	net-print/pkpgcounter
	postgres? ( dev-db/postgresql dev-db/pygresql )
	ldap?     ( net-nds/openldap dev-python/python-ldap )
	snmp?     ( net-analyzer/net-snmp dev-python/pysnmp )
	xml?      ( dev-python/jaxml )
	xml2?     ( dev-python/jaxml ) "
RDEPEND="${DEPEND}"

KEYWORDS="~x86"
SLOT="0"

src_install() {
	mkdir -p ${D}/etc/${PN}
	python_version
	distutils_src_install
	#cups backend ----------------------------------------------
	mkdir -p ${D}/usr/lib/cups/backend
	dosym /usr/share/pykota/cupspykota /usr/lib/cups/backend/cupspykota
	#extra docs: inits -----------------------------------------
	init_dir=/usr/share/doc/${PN}/initscripts
	insinto ${init_dir}
	cp -pPR initscripts/* ${D}/${init_dir}
}

