# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-4.2.4.ebuild,v 1.2 2004/02/17 00:47:57 mr_bones_ Exp $

inherit distutils

DESCRIPTION="Python bindings for BerkelyDB"
HOMEPAGE="http://pybsddb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pybsddb/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~x86" # ~ppc ~sparc"
IUSE=""

DEPEND="virtual/python
	=sys-libs/db-4.2*"

DOCS="README.txt TODO.txt"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-db4.2.patch
}

src_compile() {
	distutils_src_compile "--berkeley-db=/usr"
}

src_install() {
	distutils_src_install "--berkeley-db=/usr"
	dohtml docs/*
}

