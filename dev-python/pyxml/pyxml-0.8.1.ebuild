# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxml/pyxml-0.8.1.ebuild,v 1.4 2004/06/25 01:47:36 agriffis Exp $

inherit distutils

MY_P=${P/pyxml/PyXML}

DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${MY_P}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="virtual/python"

IUSE=""
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ia64"
LICENSE="PYTHON"

S=${WORKDIR}/${MY_P}

src_install() {
	DOCS="ANNOUNCE CREDITS PKG-INFO"
	distutils_src_install

	dohtml -r doc/*
}
