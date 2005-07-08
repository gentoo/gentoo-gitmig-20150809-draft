# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zodb/zodb-3.2.9.ebuild,v 1.1 2005/07/08 21:08:38 radek Exp $

inherit distutils

MY_P=ZODB

DESCRIPTION="Zope Object DataBase."
HOMEPAGE="http://zope.org/Products/ZODB3.2"
SRC_URI="${HOMEPAGE}/${MY_P}%20${PV}/${MY_P}3-${PV}.tgz"
IUSE=""
LICENSE="ZPL"
SLOT="3.2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-lang/python-2.3.5"

S=${WORKDIR}/${MY_P}3-${PV}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml -a html -r Doc ExtensionClass
}
