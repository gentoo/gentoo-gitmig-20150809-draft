# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyunit/pyunit-1.4.1.ebuild,v 1.5 2003/06/21 22:30:25 drobbins Exp $


inherit distutils

DESCRIPTION="PyUnit - the standard unit testing framework for Python"
HOMEPAGE="http://pyunit.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyunit/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE=""
DEPEND=">=dev-lang/python-2.0"

src_install() {
	mydoc="CHANGES examples/*"
	distutils_src_install
	dohtml -r doc/PyUnit.html
}

