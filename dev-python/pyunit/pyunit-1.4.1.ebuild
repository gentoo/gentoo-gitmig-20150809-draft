# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyunit/pyunit-1.4.1.ebuild,v 1.1 2002/10/28 18:44:13 roughneck Exp $

DESCRIPTION="PyUnit - the standard unit testing framework for Python"

HOMEPAGE="http://pyunit.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/pyunit/${P}.tar.gz"

LICENSE="as-is"

SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=">=python-2.0"
RDEPEND=""

S="${WORKDIR}/${P}"

inherit distutils

src_install() {
	mydoc="CHANGES examples/*"
	distutils_src_install
	dohtml -r doc/PyUnit.html
}

