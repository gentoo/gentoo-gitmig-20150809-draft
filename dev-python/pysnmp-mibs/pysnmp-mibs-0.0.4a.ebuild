# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp-mibs/pysnmp-mibs-0.0.4a.ebuild,v 1.1 2007/02/02 01:15:36 mjolnir Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python - mibs"
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND=">=dev-python/pysnmp-4.1.6a"
RDEPEND="${DEPEND}"

src_install(){
	distutils_src_install
}
