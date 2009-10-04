# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zodb/zodb-3.6.0-r1.ebuild,v 1.3 2009/10/04 20:10:06 arfrever Exp $
EAPI=2

inherit distutils

MY_P="ZODB"
DESCRIPTION="Zope Object DataBase"
HOMEPAGE="http://zope.org/Products/ZODB3.6"
SRC_URI="http://zope.org/Products/${MY_P}3.6/${MY_P}%20${PV}/${MY_P}3-${PV}.tgz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="<dev-lang/python-2.5"
DEPEND="${RDEPEND}
	!net-zope/zope-interface"

S=${WORKDIR}/${MY_P}3-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-CVE-2009-0668+0669.patch
}
