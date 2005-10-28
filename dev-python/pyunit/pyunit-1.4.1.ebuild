# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyunit/pyunit-1.4.1.ebuild,v 1.9 2005/10/28 04:20:04 weeve Exp $


inherit distutils

DESCRIPTION="PyUnit - the standard unit testing framework for Python"
HOMEPAGE="http://pyunit.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyunit/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""
DEPEND=">=dev-lang/python-2.0"

src_install() {
	mydoc="CHANGES examples/*"
	distutils_src_install
	dohtml -r doc/PyUnit.html
}

