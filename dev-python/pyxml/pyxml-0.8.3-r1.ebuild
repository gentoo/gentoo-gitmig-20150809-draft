# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxml/pyxml-0.8.3-r1.ebuild,v 1.1 2004/06/17 21:39:22 lucass Exp $

inherit python distutils

MY_P=${P/pyxml/PyXML}

DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${MY_P}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="virtual/python
	>=dev-libs/expat-1.95.6"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ppc64 ~ia64 ~mips"
LICENSE="PYTHON"
DOCS="ANNOUNCE CREDITS PKG-INFO LICENCE TODO doc/*.txt"
S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf

	# if you want to use 4Suite, then their XSLT/XPATH is
	# better according to the docs
	if has_version "dev-python/4suite"; then
		myconf="--without-xslt --without-xpath"
	fi

	distutils_src_compile ${myconf}
}

src_install() {
	distutils_src_install

	doman doc/man/*
	dohtml -A api,web -r doc/*
	insinto /usr/share/doc/${PF} && doins doc/*.tex
	cp -r demo ${D}/usr/share/doc/${PF}
	dodir /usr/share/${PN} && cp -r test ${D}/usr/share/${PN}
}

