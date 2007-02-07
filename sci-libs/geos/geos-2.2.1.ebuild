# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-2.2.1.ebuild,v 1.7 2007/02/07 12:25:54 djay Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"
inherit eutils autotools

DESCRIPTION="Geometry Engine - Open Source"
HOMEPAGE="http://geos.refractions.net"
SRC_URI="http://geos.refractions.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc python"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
		doc? ( app-doc/doxygen )\
		python? ( dev-lang/python dev-lang/swig )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc-41.patch
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf --enable-static || die "Error: econf failed"

	emake || die "Error: emake failed"
	if use python; then
		einfo "Compilling PyGEOS"
		cd ${S}/swig/python
		swig -c++ -python -modern -o geos_wrap.cxx ../geos.i
		python setup.py build
	fi
}

src_install(){
	into /usr
	make DESTDIR="${D}" install
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
	if use doc; then
		cd ${S}/doc
		make doxygen-html
		dohtml -r doxygen_docs/html/*
	fi
	if use python; then
		einfo "Intalling PyGEOS"
		cd ${S}/swig/python
		python setup.py install --prefix="${D}/usr/"
		insinto /usr/share/doc/${PF}/python
		doins README.txt tests/*.py
		insinto /usr/share/doc/${PF}/python/cases
		doins tests/cases/*
	fi
}

