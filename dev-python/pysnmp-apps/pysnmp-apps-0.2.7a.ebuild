# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp-apps/pysnmp-apps-0.2.7a.ebuild,v 1.1 2008/06/23 06:46:13 dev-zero Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python - applications"
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pysnmp-4.1.10a
	>=dev-python/pysnmp-mibs-0.0.6a"
RDEPEND="${DEPEND}"

DOCS="CHANGES"
PYTHON_MODNAME="pysnmp_apps"
