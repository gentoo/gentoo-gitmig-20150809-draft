# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header $

S=${WORKDIR}/${P}
DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${P}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"
LICENSE="PYTHON"

inherit distutils

src_install() {
	mydoc="ANNOUNCE CREDITS PKG-INFO demo doc/*.tex doc/*.txt"
	distutils_src_install
	dohtml -r doc/*
}
