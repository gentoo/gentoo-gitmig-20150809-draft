# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zodb/zodb-3.2.ebuild,v 1.2 2004/06/25 01:26:43 agriffis Exp $

inherit distutils

MY_P=ZODB

DESCRIPTION="Zope Object DataBase."
HOMEPAGE="http://zope.org/Products/${MY_P}${PV}"
SRC_URI="http://zope.org/Products/${MY_P}${PV}/${PV}/${MY_P}3-${PV}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-2.2.3"

S=${WORKDIR}/${MY_P}3-${PV}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml -a html -r Doc ExtensionClass
}
