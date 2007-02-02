# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp-apps/pysnmp-apps-0.2.4a.ebuild,v 1.1 2007/02/02 01:32:33 mjolnir Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python - applications"
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-python/pysnmp-4.1.6a
	dev-python/pysnmp-mibs"
RDEPEND="${DEPEND}"

src_install(){
	distutils_src_install
}

