# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.4.0_beta5.ebuild,v 1.2 2008/06/27 23:06:52 loki_val Exp $

EAPI=1

PHP_EXT_NAME=ming

inherit eutils autotools multilib php-ext-source-r1 perl-module distutils python

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
DESCRIPTION="An Open Source library for Flash movie generation."
HOMEPAGE="http://ming.sourceforge.net/"
SRC_URI="mirror://sourceforge/ming/${P/_/.}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+perl +python php"
RDEPEND="perl? ( dev-lang/perl )
	python? ( virtual/python )
	media-libs/freetype
	media-libs/libpng
	media-libs/giflib
	sys-libs/zlib
	!media-libs/libswf"
DEPEND="${DEPEND}
	>=dev-lang/swig-1.3.35
	sys-devel/flex"

S=${WORKDIR}/${P/_/.}

src_unpack() {
	unpack ${A}
	cd "${S}"

	#We need to do this with Swig >=1.3.35, or the tests will
	#fail for the python extension using gcc-4.3.
	#probably some aliasing issue with gcc-4.3*

	pushd py_ext &> /dev/null
	swig -I.. -python ming.i
	popd &> /dev/null

	#Let's get rid of the TEXTRELS, link dynamic.
	sed -i \
		-e 's/libming.a/libming.so/' \
		perl_ext/Makefile.PL
	eautoreconf
}

src_compile() {
	econf	$(use_enable perl) \
		$(use_enable python) || die "econf failed"
	emake -j1 DESTDIR="${D}" || die "emake failed"
	if use php
	then
		cd "${S}"/php_ext
		myconf="--disable-rpath
			--disable-static
			--with-ming"
		php-ext-source-r1_src_compile
	fi

}

src_test() {
	make check || die "tests failed"
}

src_install() {
	make DESTDIR="${D}" install

	fixlocalpod

	#Get rid of the precompiled stuff, we generate it later.
	rm -f $(find "${D}" -name '*.pyc')

	if use php
	then
		cd "${S}"/php_ext
		php-ext-source-r1_src_install
	fi
}

pkg_postinst() {
	if use perl
	then
		perl-module_pkg_postinst
	fi
	if use python
	then
		ebegin "Compiling ming.py"
		python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/ming.py || die "ming.py failed"
		eend $?
		ebegin "Compiling mingc.py"
		python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/mingc.py || die "mingc.py failed"
		eend $?
	fi
}

pkg_prerm() {
	if use perl
	then
		perl-module_pkg_prerm
	fi
}

pkg_postrm() {
	if use perl
	then
		perl-module_pkg_postrm
	fi
	if use python
	then
		distutils_pkg_postrm
	fi
}
