# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/log4py/log4py-1.1.ebuild,v 1.7 2004/03/28 14:17:37 kloeri Exp $

inherit distutils

DESCRIPTION="A python logging module similar to log4j"
HOMEPAGE="http://www.its4you.at/english/log4py.html"
#SRC_URI="http://www.its4you.at/downloads/files/${P}.tar.gz"
SRC_URI="mirror://sourceforge/log4py/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/python"
RDEPEND=""

src_install() {
	mydoc="doc/*.* database/* log4py-test.py"
	distutils_src_install
	dohtml -r doc/html/*

	insinto /etc
	doins log4py.conf
}
