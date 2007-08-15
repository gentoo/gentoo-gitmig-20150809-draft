# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp-apps/pysnmp-apps-0.2.6a.ebuild,v 1.1 2007/08/15 02:40:45 mjolnir Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python - applications"
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-python/pysnmp-4.1.8a
	>=dev-python/pysnmp-mibs-0.0.5a"
RDEPEND="${DEPEND}"
