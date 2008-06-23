# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp-mibs/pysnmp-mibs-0.0.6a.ebuild,v 1.1 2008/06/23 06:44:01 dev-zero Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python - mibs"
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-python/pysnmp-4.1.10a"
RDEPEND="${DEPEND}"

DOCS="CHANGES"
PYTHON_MODNAME="pysnmp_mibs"
