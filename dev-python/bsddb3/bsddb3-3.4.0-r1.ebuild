# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-3.4.0-r1.ebuild,v 1.8 2004/06/14 09:33:55 kloeri Exp $

inherit distutils eutils

DESCRIPTION="Python bindings for BerkeleyDB"
HOMEPAGE="http://pybsddb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pybsddb/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/python
	=sys-libs/db-3.2*"

DOCS="README.txt TODO.txt"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-db3.patch
}

src_install() {
	distutils_src_install
	dohtml docs/*
}

