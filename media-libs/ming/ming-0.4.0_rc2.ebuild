# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.4.0_rc2.ebuild,v 1.2 2009/12/23 21:37:34 jer Exp $

EAPI=1

PHP_EXT_NAME=ming

inherit eutils autotools multilib php-ext-source-r1 perl-module distutils python

MY_PV=0.4.2
MY_P=${PN}-${MY_PV}

KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
DESCRIPTION="An Open Source library for Flash movie generation."
HOMEPAGE="http://ming.sourceforge.net/"
SRC_URI="mirror://sourceforge/ming/${MY_P}.tar.bz2"
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
	sys-devel/flex"

S=${WORKDIR}/${MY_P/_/.}

#Tests only work when the package is tested on a system
#which does not presently have any version of ming installed.

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Let's get rid of the TEXTRELS, link dynamic. Use gif.
	sed -i \
		-e 's/libming.a/libming.so/' \
		-e 's/lungif/lgif/' \
		perl_ext/Makefile.PL
	sed -i \
		-e 's/ungif/gif/' \
		py_ext/setup.py.in

	rm macros/libtool.m4
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
		python_version
		ebegin "Compiling ming.py"
		python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/ming.py
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
