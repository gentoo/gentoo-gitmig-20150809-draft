# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zodb/zodb-3.2.6.ebuild,v 1.2 2005/04/10 12:22:39 blubb Exp $

inherit distutils

MY_P=ZODB

DESCRIPTION="Zope Object DataBase."
HOMEPAGE="http://zope.org/Products/ZODB3.2"
SRC_URI="${HOMEPAGE}/${MY_P}%203.2.6/${MY_P}3-3.2.6.tgz"
IUSE=""
LICENSE="ZPL"
SLOT="3.2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-lang/python-2.3.4"

S=${WORKDIR}/${MY_P}3-${PV}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml -a html -r Doc ExtensionClass
}
