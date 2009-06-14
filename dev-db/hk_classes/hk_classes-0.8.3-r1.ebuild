# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hk_classes/hk_classes-0.8.3-r1.ebuild,v 1.1 2009/06/14 10:30:56 scarabeus Exp $

EAPI="1"

inherit autotools eutils python

# The tests themselves are broken.
RESTRICT="strip test"

P_DOCS="${PN}-htmldocumentation-0.8"

MY_P=${P/_alpha/-test}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GUI-independent C++ libraries for database applications, including API documentation and tutorials."
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="mirror://sourceforge/hk-classes/${MY_P}.tar.bz2
	mirror://sourceforge/hk-classes/xbsql-hk_classes-0.13.tar.gz
	doc? ( mirror://sourceforge/knoda/${P_DOCS}.tar.bz2 )"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc firebird mysql odbc postgres sqlite xbase"

RDEPEND=">=media-libs/fontconfig-2.5.0-r1
	firebird? ( dev-db/firebird )
	mysql? ( >=dev-db/mysql-3.23.54a )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	postgres? ( >=virtual/postgresql-server-7.3 )
	sqlite? ( dev-db/sqlite:3 )
	xbase? ( dev-db/xbase )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# gcc-4.3 compatibility. Fixes bug 218913 and 230251.
	epatch "${FILESDIR}/${P}-gcc43.patch"

	eautoreconf
}

src_compile() {
	python_version
	export LIBPYTHON="-lpython${PYVER} -lz"
	use sqlite && myopts="--with-sqlite3systemlibrary"
	econf \
		--disable-dependency-tracking \
		--without-sqlite \
		--without-mdb \
		--without-dbase \
		--without-paradox \
		$(use_with sqlite sqlite3) \
		$(use_with mysql) \
		$(use_with firebird) \
		$(use_with odbc) \
		$(use_with postgres) \
		$(use_with xbase) \
		${myopts}

	emake || die "emake failed"
}

src_install() {
	if use doc; then
		dohtml -r "${WORKDIR}"/${MY_P}/documentation/api
		dohtml -r "${WORKDIR}"/hk_classestutorial
		dohtml -r "${WORKDIR}"/hk_kdeclssestutorial
		dohtml -r "${WORKDIR}"/knodascriptingtutorial
		dohtml -r "${WORKDIR}"/knodatutorial
		dohtml -r "${WORKDIR}"/pythonreference
	fi

	emake DESTDIR="${D}" install || die "make install failed"
}
