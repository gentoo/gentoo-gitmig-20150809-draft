# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-2.2.3.ebuild,v 1.1 2006/12/14 20:51:32 dev-zero Exp $

USE_RUBY="ruby18"
RUBY_OPTIONAL="yes"

inherit eutils distutils ruby toolchain-funcs

DESCRIPTION="Geometry Engine - Open Source"
HOMEPAGE="http://geos.refractions.net"
SRC_URI="http://geos.refractions.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc python ruby"

RDEPEND="ruby? ( virtual/ruby )
	python? ( virtual/python )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )\
	ruby?  ( >=dev-lang/swig-1.3.29 )
	python? ( >=dev-lang/swig-1.3.29 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-swig.patch"
}

src_compile() {
	econf --with-pic --enable-static || die "econf failed"
	emake || die "emake failed"

	if use python; then
	    einfo "Compilling PyGEOS"
	    cd "${S}/swig/python"
	    cp "${FILESDIR}/python.i" "${S}/swig/python/"
	    rm -f geos_wrap.cxx
	    swig -c++ -python -modern -o geos_wrap.cxx ../geos.i
	    distutils_src_compile
	fi
	if use ruby; then
	    einfo "Compilling Ruby bindings"
	    cd "${S}/swig/ruby"
	    swig -c++ -ruby -autorename -o geos_wrap.cxx ../geos.i
	    local CXX=$(tc-getCXX)
	    local RUBY_ARCHDIR="$(ruby -r rbconfig -e 'print Config::CONFIG["archdir"]')"
	    ${CXX} ${CXXFLAGS} -I../../source/headers -I${RUBY_ARCHDIR} \
			-fPIC -c geos_wrap.cxx
	    ${CXX} ${CXXFLAGS} -shared -L${S}/source/geom/.libs -lgeos \
			-lruby geos_wrap.o -o geos.so
	fi
}

src_test() {
	cd "${S}"
	emake check || die "Trying make check without success."
	# I think this test must be made after the PyGEOS installation
	#export PYTHONPATH=${S}/swig/python
	if use python; then
	    cd ${S}/swig/python
	    python tests/runtests.py -v
	fi
}

src_install(){
	emake install DESTDIR="${D}" || die "emake install failed"

	if use python; then
	    einfo "Installing PyGEOS"
	    cd ${S}/swig/python
	    distutils_src_install
	    insinto /usr/share/doc/${PF}/python
	    doins README.txt tests/*.py
	    insinto /usr/share/doc/${PF}/python/cases
	    doins tests/cases/*
	fi
	if use ruby; then
	    local RUBY_SITEARCHDIR="$(ruby -r rbconfig -e 'print Config::CONFIG["sitearchdir"]')"
	    einfo "Installing Ruby bindings in ${RUBY_SITEARCHDIR}/${PN}"
	    cd ${S}/swig/ruby
	    insinto ${RUBY_SITEARCHDIR}/${PN}
	    doins geos.so
	    insinto /usr/share/doc/${PF}/ruby
	    doins README.txt test/*.rb
	    if use doc; then
		erubydoc
	    fi
	fi
	if use doc; then
	    cd ${S}/doc
	    make doxygen-html
	    dohtml -r doxygen_docs/html/*
	fi
	cd "${S}"
	dodoc AUTHORS NEWS README TODO
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
