# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libprelude/libprelude-1.0.0-r1.ebuild,v 1.5 2011/03/31 01:26:51 arfrever Exp $

EAPI="3"
GENTOO_DEPEND_ON_PERL="no"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit autotools distutils eutils flag-o-matic perl-module

DESCRIPTION="Prelude-IDS Framework Library"
HOMEPAGE="http://www.prelude-technologies.com"
SRC_URI="${HOMEPAGE}/download/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"
IUSE="doc lua perl python ruby"

RDEPEND=">=net-libs/gnutls-1.0.17
	lua? ( dev-lang/lua )
	perl? ( dev-lang/perl )
	ruby? ( dev-lang/ruby )
	!net-analyzer/prelude-nids"
DEPEND="${RDEPEND}
	sys-devel/flex
	perl? ( dev-lang/swig )"

pkg_setup() {
	if use python; then
		python_pkg_setup
		PYTHON_DIRS="bindings/low-level/python bindings/python"
		PYTHON_MODNAME="prelude.py PreludeEasy.py"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libtool.patch
	epatch "${FILESDIR}"/${P}-ruby.patch

	# Avoid null runpaths in Perl bindings.
	sed -e 's/ LD_RUN_PATH=""//' -i bindings/Makefile.am bindings/low-level/Makefile.am || die "sed failed"

	# Python bindings are built/installed manually.
	sed -e "/^SUBDIRS =/s/ python//" -i bindings/low-level/Makefile.am bindings/Makefile.am || die "sed failed"

	eautoreconf
}

src_configure() {
	filter-lfs-flags

	# SWIG is needed to build Perl high-level bindings.
	econf \
		--enable-easy-bindings \
		$(use_enable doc gtk-doc) \
		$(use_with lua) \
		$(use_with perl) \
		$(use_with perl swig) \
		$(use_with python) \
		$(use_with ruby)
}

src_compile() {
	emake OTHERLDFLAGS="${LDFLAGS}" || die "emake failed"

	if use python; then
		local dir
		for dir in ${PYTHON_DIRS}; do
			pushd "${dir}" > /dev/null
			distutils_src_compile
			popd > /dev/null
		done
	fi
}

src_install() {
	emake DESTDIR="${D}" INSTALLDIRS=vendor install || die "make install failed"

	if use lua; then
		rm - "${ED}usr/$(get_libdir)/PreludeEasy.la"
	fi

	if use perl; then
		perl_delete_localpod
		perl_delete_packlist
	fi

	if use python; then
		local dir
		for dir in ${PYTHON_DIRS}; do
			pushd "${dir}" > /dev/null
			distutils_src_install
			popd > /dev/null
		done
	fi

	if use ruby; then
		find "${ED}/usr/$(get_libdir)/ruby" -name "*.la" -print0 | xargs -0 rm -f
	fi
}

pkg_postinst() {
	if use python; then
		distutils_pkg_postinst
	fi
}

pkg_postrm() {
	if use python; then
		distutils_pkg_postrm
	fi
}
