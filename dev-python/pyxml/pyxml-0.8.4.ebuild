# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxml/pyxml-0.8.4.ebuild,v 1.1 2004/11/30 23:35:29 pythonhead Exp $

inherit python distutils

MY_P=${P/pyxml/PyXML}

DESCRIPTION="A collection of libraries to process XML with Python"
HOMEPAGE="http://pyxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyxml/${MY_P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/python
	>=dev-libs/expat-1.95.6"

S=${WORKDIR}/${MY_P}

DOCS="ANNOUNCE CREDITS PKG-INFO TODO doc/*.txt"

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

