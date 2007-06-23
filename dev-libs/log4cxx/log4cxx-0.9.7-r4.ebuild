# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4cxx/log4cxx-0.9.7-r4.ebuild,v 1.2 2007/06/23 15:46:44 dev-zero Exp $

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="latest"

inherit autotools eutils flag-o-matic

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Library of C++ classes for flexible logging to files, syslog and other destinations"
HOMEPAGE="http://logging.apache.org/log4cxx/"
SRC_URI="http://www.apache.org/dist/logging/${PN}/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc iodbc unicode odbc smtp test threads"

RDEPEND="dev-libs/libxml2
	odbc? (
		iodbc? ( >=dev-db/libiodbc-3.52.4 )
		!iodbc? ( dev-db/unixODBC ) )
	smtp? ( dev-libs/libsmtp )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen media-gfx/graphviz )
	test? ( dev-libs/boost dev-util/cppunit )"

pkg_setup() {
	if use iodbc && ! use odbc ; then
		elog "Please enable the odbc USE-flag as well if you want odbc-support through iodbc."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:\(htmldir = \).*\(/html\):\1\$(datadir)/doc/${PF}\2:" \
		docs/Makefile.am || die "sed failed"

	epatch "${FILESDIR}/${P}-gentoo.diff"

	if use unicode && use odbc ; then
		epatch "${FILESDIR}/${P}-use-SQLWCHAR.diff"
	fi

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-tchar.patch"

	# Fix a bug in the tests
	sed -i -e 's/regex.hpp/cregex.hpp/' \
		tests/src/util/filter.cpp || die "sed failed"

	eautoreconf
}

src_compile() {
	use smtp && myconf="${myconf} --with-SMTP=libsmtp"
	if use odbc ; then
		if use iodbc ; then
			myconf="${myconf} --with-ODBC=iODBC"
		else
			myconf="${myconf} --with-ODBC=unixODBC"
		fi
	fi
	# it's broken, so we must do this rather than use_enable
	use unicode && myconf="${myconf} --enable-unicode"
	use test && myconf="${myconf} --enable-cppunit"
	use threads && myconf="${myconf} --with-thread=pthread"

	if use unicode && use odbc ; then
		# fix some warnings as w/o it TCHAR gets typedef'd to signed short
		# instead of wchar_t
		append-flags -DSQL_WCHART_CONVERT
	fi

	econf \
		--with-XML=libxml2 \
		$(use_enable doc doxygen) \
		$(use_enable doc dot) \
		$(use_enable doc html-docs) \
		${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
