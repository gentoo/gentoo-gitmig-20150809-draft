# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/pears/pears-1.7.ebuild,v 1.1 2004/07/23 01:00:49 pythonhead Exp $

inherit python

DESCRIPTION="RSS/RDF and Atom news aggregator GUI"
HOMEPAGE="http://project5.freezope.org/pears/index.html"
SRC_URI="mirror://sourceforge/pears/${P}.tgz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=dev-lang/python-2.2
	>=dev-python/wxpython-2.4.2.4"

src_install() {
	python_version
	dodir /usr/lib/python${PYVER}/site-packages/${PN}
	dohtml -r docs/*
	dodoc *.txt
	insinto /usr/lib/python${PYVER}/site-packages/${PN}
	doins *.py *.ico *.wxg *.jpg *.dat
	dodir /usr/bin
	echo '#!/bin/sh' > pears
	echo "cd /usr/lib/python${PYVER}/site-packages/${PN}" >> pears
	echo 'python pears.py "$@"' >> pears
	exeinto /usr/bin
	doexe pears
}
