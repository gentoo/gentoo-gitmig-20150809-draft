# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/empy/empy-3.2.ebuild,v 1.4 2007/06/25 07:40:06 hawking Exp $

inherit distutils

DESCRIPTION="A powerful and robust templating system for Python"
HOMEPAGE="http://www.alcyone.com/software/empy/"
SRC_URI="http://www.alcyone.com/software/empy/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:/usr/local/bin/python:/usr/bin/python:g" em.py \
		|| die "Failed to patch em.py"
}

src_install() {
	distutils_src_install
	distutils_python_version
	dodir /usr/bin
	fperms 755 /usr/lib/python${PYVER}/site-packages/em.py
	dosym /usr/lib/python${PYVER}/site-packages/em.py /usr/bin/em.py
	dodir /usr/share/doc/${PF}/examples
	insinto /usr/share/doc/${PF}/examples
	doins sample.em sample.bench
	#3.2 has the html in this funny place. Fix in later version:
	dohtml doc/home/max/projects/empy/doc/em/*
	dohtml doc/home/max/projects/empy/doc/em.html
	dohtml doc/index.html
}
