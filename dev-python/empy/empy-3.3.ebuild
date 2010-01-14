# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/empy/empy-3.3.ebuild,v 1.12 2010/01/14 19:54:26 ranger Exp $

inherit distutils

DESCRIPTION="A powerful and robust templating system for Python"
HOMEPAGE="http://www.alcyone.com/software/empy/"
SRC_URI="http://www.alcyone.com/software/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE="doc"
DEPEND="dev-lang/python"
PYTHON_MODNAME="em.py"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:/usr/local/bin/python:/usr/bin/python:g" em.py \
		|| die "Failed to patch em.py"
}

src_install() {
	distutils_src_install
	dodir /usr/bin
	fperms 755 "$(python_get_sitedir)/em.py"
	dosym $(python_get_sitedir)/em.py /usr/bin/em.py || \
		die "dosym failed"
	if use doc ; then
		dodir /usr/share/doc/"${PF}"/examples
		insinto /usr/share/doc/"${PF}"/examples
		doins sample.em sample.bench
		#3.3 has the html in this funny place. Fix in later version:
		dohtml doc/home/max/projects/empy/doc/em/*
		dohtml doc/home/max/projects/empy/doc/em.html
		dohtml doc/index.html
	fi
}

src_test() {
	./test.sh ${python} || die "tests failed"
}
