# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libprelude/libprelude-1.0.0-r1.ebuild,v 1.3 2011/03/29 22:34:12 arfrever Exp $

EAPI="3"
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
IUSE="doc easy-bindings perl python swig"

RDEPEND=">=net-libs/gnutls-1.0.17
	!net-analyzer/prelude-nids"

DEPEND="${RDEPEND}
	sys-devel/flex"

pkg_setup() {
	if use python; then
		python_pkg_setup

		if use easy-bindings; then
			PYTHON_DIRS="bindings/low-level/python bindings/python"
			PYTHON_MODNAME="prelude.py PreludeEasy.py"
		else
			PYTHON_DIRS="bindings/low-level/python"
			PYTHON_MODNAME="prelude.py"
		fi
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libtool.patch

	# Python bindings are built/installed manually.
	sed -e "/^SUBDIRS =/s/ python//" -i bindings/low-level/Makefile.am bindings/Makefile.am || die "sed failed"

	eautoreconf
}

src_configure() {
	filter-lfs-flags
	econf \
		$(use_enable doc gtk-doc) \
		$(use_with swig) \
		$(use_with perl) \
		$(use_with python) \
		$(use_enable easy-bindings)
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
