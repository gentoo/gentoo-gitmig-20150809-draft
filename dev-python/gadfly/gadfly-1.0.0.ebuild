# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/gadfly/gadfly-1.0.0.ebuild,v 1.4 2003/04/23 15:17:53 vapier Exp $

DESCRIPTION="relational database system implemented in Python"
SRC_URI="mirror://sourceforge/gadfly/${P}.tar.gz"
HOMEPAGE="http://gadfly.sourceforge.net/"

SLOT="0"
KEYWORDS="x86"
LICENSE="BSD"

DEPEND="virtual/python"

src_compile() {
	python setup.py build || die "gadfly compilation failed"
	cd kjbuckets
	python setup.py build || die "kjbuckets compilation failed"
}

src_install() {
	dodoc *.txt doc/*.txt
	python setup.py install --root=${D} || die
	cd kjbuckets
	python setup.py install --root=${D} || die
}
