# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/log4py/log4py-1.1.ebuild,v 1.5 2003/06/22 12:15:59 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A python logging module similar to log4j"
SRC_URI="http://www.its4you.at/downloads/files/${P}.tar.gz"
HOMEPAGE="http://www.its4you.at/english/log4py.html"

DEPEND="virtual/python"
RDEPEND=""
IUSE=""

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="MIT"

inherit distutils

src_install() {
	mydoc="doc/*.* database/* log4py-test.py"
	distutils_src_install
	dohtml -r doc/html/*

	insinto /etc
	doins log4py.conf
}

