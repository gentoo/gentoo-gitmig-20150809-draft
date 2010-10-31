# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pykota/pykota-1.25_p2437-r1.ebuild,v 1.6 2010/10/31 18:57:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Flexible print quota and accounting package for use with CUPS and lpd."
HOMEPAGE="http://www.pykota.com"
SRC_URI="http://scriptkitty.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap mysql postgres snmp sqlite snmp xml"

DEPEND="dev-lang/python
	dev-python/egenix-mx-base
	net-print/pkpgcounter
	dev-python/chardet
	dev-python/pkipplib
	ldap?     ( dev-python/python-ldap )
	mysql?    ( dev-python/mysql-python )
	postgres? ( dev-db/postgresql-server dev-db/pygresql )
	sqlite?   ( dev-python/pysqlite:2 )
	snmp?     ( net-analyzer/net-snmp =dev-python/pysnmp-3.4* )
	xml?      ( dev-python/jaxml )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

DOCS="README MANIFEST.in TODO SECURITY NEWS CREDITS FAQ"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	mkdir -p "${D}"/etc/${PN}
	distutils_src_install
	#cups backend ----------------------------------------------
	mkdir -p "${D}"$(cups-config --serverbin)/backend
	dosym /usr/share/pykota/cupspykota $(cups-config --serverbin)/backend/cupspykota
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
