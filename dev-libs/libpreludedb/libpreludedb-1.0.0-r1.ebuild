# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpreludedb/libpreludedb-1.0.0-r1.ebuild,v 1.9 2012/06/23 09:29:00 ssuominen Exp $

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
KEYWORDS="~amd64 ~x86"
IUSE="doc mysql postgres perl python sqlite"

RDEPEND=">=dev-libs/libprelude-0.9.9
	mysql? ( virtual/mysql )
	perl? ( dev-lang/perl )
	postgres? ( dev-db/postgresql-server )
	sqlite? ( =dev-db/sqlite-3* )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	doc? ( dev-util/gtk-doc )"

DISTUTILS_SETUP_FILES=("bindings/python|setup.py")
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

	rm -f m4/gtk-doc.m4 #420767

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
		distutils_src_compile
	fi
}

src_install() {
	emake -j1 DESTDIR="${D}" INSTALLDIRS=vendor install || die "make install failed"

	if use perl; then
		perl_delete_localpod
		perl_delete_packlist
	fi

	if use python; then
		distutils_src_install
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
