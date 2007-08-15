# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-4.1.8a.ebuild,v 1.1 2007/08/15 02:38:19 mjolnir Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python. Not a wrapper."
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-python/pyasn1-0.0.6a
	dev-python/pycrypto"
RDEPEND="${DEPEND}"

src_install(){
	distutils_src_install

	dodoc CHANGES
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
