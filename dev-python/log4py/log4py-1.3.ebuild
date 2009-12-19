# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/log4py/log4py-1.3.ebuild,v 1.11 2009/12/19 21:39:56 arfrever Exp $

inherit distutils

DESCRIPTION="A python logging module similar to log4j"
HOMEPAGE="http://www.its4you.at/english/log4py.html"
SRC_URI="http://www.its4you.at/downloads/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="doc/AUTHORS doc/ChangeLog database/* log4py-test.py"
PYTHON_MODNAME="log4py.py"

src_install() {
	distutils_src_install
	dohtml -r doc/html/*

	insinto /etc
	doins log4py.conf
}
