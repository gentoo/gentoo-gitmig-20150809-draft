# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/ldapuserfolder/ldapuserfolder-2.20.ebuild,v 1.1 2011/05/05 15:40:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython"

inherit distutils

MY_PN="Products.LDAPUserFolder"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A LDAP-enabled Zope 2 user folder"
HOMEPAGE="http://pypi.python.org/pypi/Products.LDAPUserFolder"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

# Optional dependencies:
# net-zope/cmfdefault
# net-zope/genericsetup
RDEPEND=">=dev-python/python-ldap-2.0.6
	net-zope/accesscontrol
	net-zope/acquisition
	net-zope/datetime
	net-zope/persistence
	net-zope/zodb
	>=net-zope/zope-2.12
	net-zope/zope-component
	net-zope/zope-interface"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="Products/LDAPUserFolder/CHANGES.txt Products/LDAPUserFolder/HISTORY.txt Products/LDAPUserFolder/README.ActiveDirectory.txt Products/LDAPUserFolder/README.txt Products/LDAPUserFolder/SAMPLE_RECORDS.txt"
PYTHON_MODNAME="${MY_PN/.//}"

pkg_postinst() {
	python_mod_optimize -x /skins/ ${MY_PN/.//}
}
