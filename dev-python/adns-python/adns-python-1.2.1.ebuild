# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adns-python/adns-python-1.2.1.ebuild,v 1.11 2010/07/14 17:21:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python bindings for ADNS"
HOMEPAGE="http://code.google.com/p/adns-python/"
SRC_URI="http://adns-python.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/adns-1.3"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="ADNS.py DNSBL.py"
