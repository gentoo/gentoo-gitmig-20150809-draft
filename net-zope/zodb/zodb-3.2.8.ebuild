# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zodb/zodb-3.2.8.ebuild,v 1.3 2006/01/27 02:51:32 vapier Exp $

inherit distutils

MY_P=ZODB
DESCRIPTION="Zope Object DataBase"
HOMEPAGE="http://zope.org/Products/ZODB3.2"
SRC_URI="${HOMEPAGE}/${MY_P}%20${PV}/${MY_P}3-${PV}.tgz"

LICENSE="ZPL"
SLOT="3.2"
KEYWORDS="~amd64 x86"
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
