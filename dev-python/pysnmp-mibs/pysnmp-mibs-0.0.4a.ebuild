# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp-mibs/pysnmp-mibs-0.0.4a.ebuild,v 1.3 2007/02/05 05:42:04 mjolnir Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python - mibs"
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-python/pysnmp-4.1.6a"
RDEPEND="${DEPEND}"
