# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4cxx/log4cxx-0.9.7-r2.ebuild,v 1.3 2005/06/28 08:24:37 blubb Exp $

inherit eutils flag-o-matic

DESCRIPTION="Library of C++ classes for flexible logging to files, syslog and other destinations"
HOMEPAGE="http://logging.apache.org/log4cxx/"
SRC_URI="http://www.apache.org/dist/logging/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc unicode odbc smtp"

DEPEND="virtual/libc
		dev-libs/libxml2
		doc? ( app-doc/doxygen media-gfx/graphviz )
		odbc? ( dev-db/unixODBC )
		smtp? ( dev-libs/libsmtp )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:\(htmldir = \).*\(/html\):\1\$(datadir)/doc/${PF}\2:" \
		docs/Makefile.am || die "sed failed"

	epatch ${FILESDIR}/${P}-gentoo.diff

	if use unicode && use odbc ; then
		epatch ${FILESDIR}/${P}-use-SQLWCHAR.diff
	fi
}

src_compile() {
	${S}/autogen.sh || die "autogen.sh failed"

	# has cppunit support, but make check builds nothing...
	local myconf="--disable-cppunit"
	use doc && myconf="${myconf} --enable-doxygen --enable-dot
		--enable-html-docs --enable-latex-docs" || \
		myconf="${myconf} --disable-doxygen --disable-dot --disable-html-docs"
	use smtp && myconf="${myconf} --with-SMTP=libsmtp"
	use odbc && myconf="${myconf} --with-ODBC=unixODBC"
	# it's broken, so we must do this rather than use_enable
	use unicode && myconf="${myconf} --enable-unicode"

	if use unicode && use odbc ; then
		# fix some warnings as w/o it TCHAR gets typedef'd to signed short
		# instead of wchar_t
		append-flags -DSQL_WCHART_CONVERT
	fi

	econf ${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
