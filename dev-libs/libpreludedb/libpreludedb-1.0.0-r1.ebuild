# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpreludedb/libpreludedb-1.0.0-r1.ebuild,v 1.5 2011/03/31 01:44:16 arfrever Exp $

EAPI="3"
GENTOO_DEPEND_ON_PERL="no"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit autotools distutils eutils perl-module

DESCRIPTION="Prelude-IDS framework for easy access to the Prelude database"
HOMEPAGE="http://www.prelude-technologies.com"
SRC_URI="${HOMEPAGE}/download/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc mysql postgres perl python sqlite"

RDEPEND=">=dev-libs/libprelude-0.9.9
	mysql? ( virtual/mysql )
	perl? ( dev-lang/perl )
	postgres? ( dev-db/postgresql-server )
	sqlite? ( =dev-db/sqlite-3* )"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

PYTHON_MODNAME="preludedb.py"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch

	# Avoid null runpaths in Perl bindings.
	sed -e 's/ LD_RUN_PATH=""//' -i bindings/Makefile.am || die "sed failed"

	# Python bindings are built/installed manually.
	sed \
		-e "s/^python: python-build/python:/" \
		-e "/cd python && \$(PYTHON) setup.py install/d" \
		-i bindings/Makefile.am || die "sed failed"

	eautoreconf
}

src_configure() {
	local myconf

	econf \
		$(use_enable doc gtk-doc) \
		$(use_with mysql) \
		$(use_with postgres postgresql) \
		$(use_with sqlite sqlite3) \
		$(use_with perl) \
		$(use_with python)
}

src_compile() {
	default

	if use python; then
		pushd bindings/python > /dev/null
		distutils_src_compile
		popd > /dev/null
	fi
}

src_install() {
	emake -j1 DESTDIR="${D}" INSTALLDIRS=vendor install || die "make install failed"

	if use perl; then
		perl_delete_localpod
		perl_delete_packlist
	fi

	if use python; then
		pushd bindings/python > /dev/null
		distutils_src_install
		popd > /dev/null
	fi
}

pkg_postinst() {
	if use python; then
		distutils_pkg_postinst
	fi

	elog "For additional installation instructions go to"
	elog "https://trac.prelude-ids.org/wiki/InstallingLibpreludedb"
}

pkg_postrm() {
	if use python; then
		distutils_pkg_postrm
	fi
}
