# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-2.2.2.ebuild,v 1.3 2006/07/04 00:40:09 nerdboy Exp $

inherit eutils distutils autotools kde-functions

DESCRIPTION="Geometry Engine - Open Source"
HOMEPAGE="http://geos.refractions.net"
SRC_URI="http://geos.refractions.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="static doc python"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	python? ( dev-lang/python
		  >=dev-lang/swig-1.3.29 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	need-autoconf 2.5
	elibtoolize
	use python && epatch ${FILESDIR}/${P}-swig.patch
}

src_compile() {
	cd ${S}
	local myconf
	myconf=""
	if use static; then
	    myconf="$(use_enable static)"
	elif use python || use ruby; then
	    myconf="--with-pic"
	else
	    myconf="--with-pic --enable-static=no"
	fi

	econf ${myconf} || die "Error: econf failed"

	# intermittent build failures with emake
	make || die "Error: make failed"

	if use python; then
		einfo "Compilling PyGEOS"
		cd ${S}/swig/python
		cp ${FILESDIR}/python.i ${S}/swig/python/
		rm -f geos_wrap.cxx
		swig -c++ -python -modern -o geos_wrap.cxx ../geos.i
		distutils_src_compile
	fi
}

src_test() {
	cd ${S}
	make check || die "Tring make check without success."
	# I think this test must be made after the PyGEOS installation
	#export PYTHONPATH=${S}/swig/python
	if use python; then
		cd ${S}/swig/python
		python tests/runtests.py -v
	fi
}

src_install(){
	make install DESTDIR=${D} || die "make install failed"

	if use python; then
		einfo "Intalling PyGEOS"
		cd ${S}/swig/python
		distutils_src_install
		insinto /usr/share/doc/${PF}/python
		doins README.txt tests/*.py
		insinto /usr/share/doc/${PF}/python/cases
		doins tests/cases/*
	fi
	if use doc; then
		cd ${S}/doc
		make doxygen-html
		dohtml -r doxygen_docs/html/*
	fi
	cd ${S}
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}

pkg_postinst() {
	if use python; then
	    python_version
	    python_mod_optimize ${ROOT}usr/bin
	fi
}

pkg_postrm() {
	if use python; then
	    python_version
	    python_mod_cleanup
	fi
}
