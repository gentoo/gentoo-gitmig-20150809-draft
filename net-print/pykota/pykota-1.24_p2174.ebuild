# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pykota/pykota-1.24_p2174.ebuild,v 1.1 2006/04/18 08:41:13 satya Exp $

inherit python eutils distutils

DESCRIPTION="PyKota - Python print Quota for CUPS, LPRng and BSD printer servers"
SRC_URI="http://www.gentoo.org/~satya/packages/pykota/${P}.tar.bz2"
HOMEPAGE="http://www.librelogiciel.com/software/PyKota/Presentation/action_Presentation"
LICENSE="GPL-2"

IUSE="ldap mysql postgres snmp sqlite snmp xml"

DEPEND="dev-lang/python
	dev-python/egenix-mx-base
	net-print/pkpgcounter
	ldap?     ( net-nds/openldap dev-python/python-ldap )
	mysql?    ( dev-db/mysql dev-python/mysql-python )
	postgres? ( dev-db/postgresql dev-db/pygresql )
	sqlite?   ( dev-db/sqlite dev-python/pysqlite )
	snmp?     ( net-analyzer/net-snmp =dev-python/pysnmp-3.4.2 )
	xml?      ( dev-python/jaxml )
	"
RDEPEND="${DEPEND}"

KEYWORDS="~amd64 ~x86"
SLOT="0"

src_install() {
	echo ${S}
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

