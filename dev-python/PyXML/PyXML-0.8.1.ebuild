# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyXML/PyXML-0.8.1.ebuild,v 1.12 2003/07/18 20:25:04 tester Exp $

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${P}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
LICENSE="PYTHON"

inherit distutils

src_install() {

	mydoc="ANNOUNCE CREDITS PKG-INFO doc/*.tex"

	distutils_src_install

	dohtml -r doc/*

}
