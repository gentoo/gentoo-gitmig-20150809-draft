# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/irman-python/irman-python-0.1.ebuild,v 1.2 2002/08/16 02:49:58 murphy Exp $

DESCRIPTION="A minimal set of Python bindings for libirman."
SRC_URI="http://bluweb.com/chouser/proj/${PN}/${P}.tar.gz"
HOMEPAGE="http://bluweb.com/chouser/proj/irman-python/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="media-libs/libirman"
#RDEPEND=""

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} || die
	dodoc README test_name.py
}
