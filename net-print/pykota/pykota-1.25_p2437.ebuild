# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pykota/pykota-1.25_p2437.ebuild,v 1.3 2007/06/26 02:37:13 mr_bones_ Exp $

S=${WORKDIR}/${PN}

inherit python eutils distutils

DESCRIPTION="Flexible print quota and accounting package for use with CUPS and
lpd."
SRC_URI="http://scriptkitty.com/files/${P}.tar.bz2"
HOMEPAGE="http://www.pykota.com"
LICENSE="GPL-2"

IUSE="ldap mysql postgres snmp sqlite snmp xml"

DEPEND="dev-lang/python
	dev-python/egenix-mx-base
	net-print/pkpgcounter
	dev-python/chardet
	dev-python/pkipplib
	ldap?     ( dev-python/python-ldap )
	mysql?    ( dev-python/mysql-python )
	postgres? ( dev-db/postgresql dev-db/pygresql )
	sqlite?   ( =dev-python/pysqlite-2* )
	snmp?     ( net-analyzer/net-snmp =dev-python/pysnmp-3.4.2 )
	xml?      ( dev-python/jaxml )"

RDEPEND="${DEPEND}"

KEYWORDS="~amd64 ~x86"
SLOT="0"

DOCS="README MANIFEST.in TODO SECURITY NEWS CREDITS FAQ"

src_install() {
	mkdir -p "${D}"/etc/${PN}
	python_version
	distutils_src_install
	#cups backend ----------------------------------------------
	mkdir -p "${D}"/usr/lib/cups/backend
	dosym /usr/share/pykota/cupspykota /usr/lib/cups/backend/cupspykota
	#extra docs: inits -----------------------------------------
	init_dir=/usr/share/doc/${P}/initscripts
	insinto ${init_dir}
	cp -pPR initscripts/* "${D}"/${init_dir}

	# Fixes permissions for bug 155865
	chmod 700 "${D}"/usr/share/pykota/cupspykota

	for doc in ${DOCS}; do
		rm -f "${D}"/usr/share/doc/${PN}/${doc}
	done

	rm -f "${D}"/usr/share/doc/${PN}/{LICENSE,COPYING}
	mv "${D}"/usr/share/doc/${PN}/* "${D}"/usr/share/doc/${P}
	rmdir "${D}"/usr/share/doc/${PN}
}

