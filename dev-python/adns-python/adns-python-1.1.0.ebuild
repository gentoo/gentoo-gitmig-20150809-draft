# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adns-python/adns-python-1.1.0.ebuild,v 1.1 2005/02/12 10:40:21 kloeri Exp $

inherit distutils

DESCRIPTION="Python bindings for ADNS"
HOMEPAGE="http://dustman.net/andy/python/adns-python"
SRC_URI="http://dustman.net/andy/python/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND="virtual/python
	>=net-libs/adns-1.0"
