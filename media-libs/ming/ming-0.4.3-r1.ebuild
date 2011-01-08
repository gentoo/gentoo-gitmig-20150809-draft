# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.4.3-r1.ebuild,v 1.1 2011/01/08 06:59:18 robbat2 Exp $

EAPI="3"

PHP_EXT_NAME=ming
PYTHON_DEPEND="python? 2"

inherit eutils autotools flag-o-matic multilib php-ext-source-r2 perl-module python

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
DESCRIPTION="An Open Source library for Flash movie generation."
HOMEPAGE="http://ming.sourceforge.net/"
SRC_URI="mirror://sourceforge/ming/${P}.tar.bz2"
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

S=${WORKDIR}/${P/_/.}

# Tests only work when the package is tested on a system
# which does not presently have any version of ming installed.
RESTRICT="test"

pkg_setup() {
	use python && python_set_active_version 2
}

src_prepare() {
	# Let's get rid of the TEXTRELS, link dynamic. Use gif.
	sed -i \
		-e 's/libming.a/libming.so/' \
		-e 's/lungif/lgif/' \
		perl_ext/Makefile.PL
	sed -i \
		-e 's/ungif/gif/' \
		py_ext/setup.py.in

	if use php; then
		cd "${S}/php_ext"
		php-ext-source-r1_phpize
		cd "${S}"
	fi

	eautoreconf
}

src_configure() {
	# build is sensitive to -O3 (bug #297437)
	replace-flags -O3 -O2

	econf $(use_enable perl) $(use_enable python)
}

src_compile() {
	emake -j1 DESTDIR="${D}" || die "emake failed"

	if use php; then
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
	make DESTDIR="${D}" INSTALLDIRS="vendor" install

	fixlocalpod

	# Get rid of the precompiled stuff, we generate it later.
	find "${ED}" -name "*.pyc" -print0 | xargs -0 rm -f

	if use php; then
		cd "${S}"/php_ext
		php-ext-source-r1_src_install
	fi
}

pkg_postinst() {
	use perl && perl-module_pkg_postinst
	use python && python_mod_optimize ming.py mingc.py
}

pkg_prerm() {
	use perl && perl-module_pkg_prerm
}

pkg_postrm() {
	use perl && perl-module_pkg_postrm
	use python && python_mod_cleanup ming.py mingc.py
}
