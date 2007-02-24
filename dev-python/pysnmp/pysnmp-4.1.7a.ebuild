# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-4.1.7a.ebuild,v 1.1 2007/02/24 21:04:42 mjolnir Exp $

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

mydoc="CHANGES"

src_install(){
	distutils_src_install

	dohtml docs/*.{html,gif}
	insinto /usr/share/doc/${PF}
	doins -r examples docs/mibs
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo "You may also be interested in the following packages: "
	einfo "dev-python/pysnmp-apps - example programs using pysnmp"
	einfo "dev-python/pysnmp-mibs - IETF and other mibs"
	einfo "net-libs/libsmi - to dump MIBs in python format"
}
