# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-4.1.15a.ebuild,v 1.2 2011/01/26 17:12:59 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="SNMP framework"
HOMEPAGE="http://pysnmp.sf.net/ http://pypi.python.org/pypi/pysnmp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=dev-python/pyasn1-0.0.6a
	dev-python/pycrypto"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES README THANKS TODO"

src_install(){
	distutils_src_install

	dohtml docs/*.{html,gif}
	insinto /usr/share/doc/${PF}
	doins -r examples docs/mibs
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "You may also be interested in the following packages: "
	elog "dev-python/pysnmp-apps - example programs using pysnmp"
	elog "dev-python/pysnmp-mibs - IETF and other mibs"
	elog "net-libs/libsmi - to dump MIBs in python format"
}
