# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gadfly/gadfly-1.0.0.ebuild,v 1.13 2005/04/24 09:18:53 blubb Exp $

DESCRIPTION="relational database system implemented in Python"
HOMEPAGE="http://gadfly.sourceforge.net/"
SRC_URI="mirror://sourceforge/gadfly/${P}.tar.gz"

KEYWORDS="x86 amd64 ppc"
SLOT="0"
LICENSE="BSD"
IUSE=""

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
