# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/log4py/log4py-1.1.ebuild,v 1.1 2002/11/03 21:17:49 roughneck Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A python logging module similar to log4j"
SRC_URI="http://www.its4you.at/downloads/files/${P}.tar.gz"
HOMEPAGE="http://www.its4you.at/english/log4py.html"

DEPEND="virtual/python"
RDEPEND=""
IUSE=""

SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="MIT"

inherit distutils

src_install() {
	mydoc="doc/*.* database/* log4py-test.py"
	distutils_src_install
	dohtml -r doc/html/*

	insinto /etc
	doins log4py.conf
}

