# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zodb/zodb-3.3.ebuild,v 1.2 2005/01/14 22:16:59 radek Exp $

inherit distutils

MY_P=ZODB

DESCRIPTION="Zope Object DataBase."
HOMEPAGE="http://zope.org/Products/${MY_P}${PV}"
SRC_URI="http://zope.org/Products/${MY_P}${PV}/${PV}/${MY_P}3-${PV}.tgz"

LICENSE="ZPL"
SLOT="3.3"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3.4"

S=${WORKDIR}/${MY_P}3-${PV}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml -a html -r Doc ExtensionClass
}
