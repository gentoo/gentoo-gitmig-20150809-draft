# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pykota/pykota-20050404.ebuild,v 1.1 2005/04/04 12:30:34 satya Exp $

#==============================================================================
inherit python eutils distutils
#--------------------------------------------------------------------------
MY_P=${P/-/_}
DESCRIPTION="PyKota - Python print Quota for CUPS, LPRng and BSD printer servers"
SRC_URI="http://www.gentoo.org/~satya/packages/pykota/${MY_P}.tar.bz2"
HOMEPAGE="http://www.librelogiciel.com/software/PyKota/Presentation/action_Presentation"
LICENSE="GPL-2"
#--------------------------------------------------------------------------
IUSE="ldap postgres snmp xml xml2"
#--------------------------------------------------------------------------
DEPEND="dev-lang/python
	dev-python/egenix-mx-base
	postgres? ( dev-db/postgresql dev-db/pygresql )
	ldap?     ( net-nds/openldap dev-python/python-ldap )
	snmp?     ( net-analyzer/net-snmp dev-python/pysnmp )
	xml?      ( dev-python/jaxml )
	xml2?     ( dev-python/jaxml ) "
#--------------------------------------------------------------------------
KEYWORDS="~x86"
SLOT="0"
#--------------------------------------------------------------------------
S="${WORKDIR}/${MY_P}"
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
	mkdir -p ${D}/etc/${PN}
	python_version
	distutils_src_install
	#cups backend ----------------------------------------------
	mkdir -p ${D}/usr/lib/cups/backend
	dosym /usr/share/pykota/cupspykota /usr/lib/cups/backend/cupspykota
	#extra docs: inits -----------------------------------------
	init_dir=/usr/share/doc/${PN}/initscripts
	insinto ${init_dir}
	cp -a initscripts/* ${D}/${init_dir}
}

