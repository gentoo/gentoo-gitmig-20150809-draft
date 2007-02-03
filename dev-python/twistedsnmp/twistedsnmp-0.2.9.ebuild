# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twistedsnmp/twistedsnmp-0.2.9.ebuild,v 1.4 2007/02/03 09:16:11 mr_bones_ Exp $

inherit distutils
MY_PN="TwistedSNMP"
MY_PV="${PV}" # change when version has an a1 or similar extension

DESCRIPTION="SNMP protocols and APIs for use with the Twisted networking framework"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0" # should only be the one version installed
KEYWORDS="~ia64 ~ppc ~x86"

IUSE=""
DEPEND="virtual/python
	>=dev-python/pysnmp-3.0.0
	>=dev-python/twisted-1.3"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_install() {
	distutils_src_install
	dohtml doc/index.html
	insinto /usr/share/doc/${PF}/html/style/
	doins doc/style/sitestyle.css
}
