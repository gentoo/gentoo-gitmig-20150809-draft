# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pykota/pykota-1.22_p1548.ebuild,v 1.4 2006/08/24 14:36:03 chutzpah Exp $

#==============================================================================
inherit python eutils distutils
#--------------------------------------------------------------------------
DESCRIPTION="PyKota - Python print Quota for CUPS, LPRng and BSD printer servers"
SRC_URI="http://www.gentoo.org/~satya/packages/pykota/${P}.tar.gz"
HOMEPAGE="http://www.librelogiciel.com/software/PyKota/Presentation/action_Presentation"
LICENSE="GPL-2"
#--------------------------------------------------------------------------
IUSE="ldap postgres snmp xml"
#--------------------------------------------------------------------------
DEPEND="dev-lang/python
	dev-python/egenix-mx-base
	postgres? ( dev-db/postgresql dev-db/pygresql )
	ldap?     ( net-nds/openldap dev-python/python-ldap )
	snmp?     ( net-analyzer/net-snmp dev-python/pysnmp )
	xml?      ( dev-python/jaxml ) "
#--------------------------------------------------------------------------
KEYWORDS="~x86"
SLOT="0"
#--------------------------------------------------------------------------
#S="${WORKDIR}/${MY_P}"
DOCS="README MANIFEST.in TODO SECURITY NEWS CREDITS FAQ"
#==============================================================================
src_unpack() {
	unpack ${A}
	cd ${S}
	cp setup.py setup.py.ORIG
	sed -e "s|DEBIAN_BUILD_PACKAGE = 0|DEBIAN_BUILD_PACKAGE = 1|;\
		s|ETC_DIR = \"./debian/tmp/etc/pykota/\"|ETC_DIR = \"${D}/etc/${PN}\"|" \
		setup.py.ORIG > setup.py
	rm -rf `find . -iname CVS -type d` 2>/dev/null
}
#==============================================================================
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

	for doc in ${DOCS}; do
		rm -f "${D}"/usr/share/doc/${PN}/${doc}
	done

	rm -f "${D}"/usr/share/doc/${PN}/{LICENSE,COPYING}
	mv "${D}"/usr/share/doc/${PN}/* "${D}"/usr/share/doc/${P}
	rmdir "${D}"/usr/share/doc/${PN}
}

