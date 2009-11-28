# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twistedsnmp/twistedsnmp-0.3.13.ebuild,v 1.1 2009/11/28 17:54:40 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="TwistedSNMP"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SNMP protocols and APIs for use with the Twisted networking framework"
HOMEPAGE="http://twistedsnmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="=dev-python/pysnmp-3*
	>=dev-python/twisted-1.3"
DEPEND="${RDEPEND}
	test? ( dev-python/nose )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml doc/index.html
	insinto /usr/share/doc/${PF}/html/style/
	doins doc/style/sitestyle.css
}
