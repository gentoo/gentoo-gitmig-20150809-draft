# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hk_classes/hk_classes-0.8.3.ebuild,v 1.3 2008/04/25 23:38:01 philantrop Exp $

inherit eutils python

# The tests themselves are broken.
RESTRICT="strip test"

P_DOCS="hk_classes-htmldocumentation-0.8"

MY_P=${P/_alpha/-test}
S=${WORKDIR}/${MY_P}

DESCRIPTION="GUI-independent C++ libraries for database applications, including API documentation and tutorials."
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="mirror://sourceforge/hk-classes/${MY_P}.tar.bz2
	mirror://sourceforge/hk-classes/xbsql-hk_classes-0.13.tar.gz
	doc? ( mirror://sourceforge/knoda/${P_DOCS}.tar.bz2 )"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc firebird mysql odbc postgres"

DEPEND=">=media-libs/fontconfig-2.5.0-r1
	firebird? ( dev-db/firebird )
	mysql? ( >=dev-db/mysql-3.23.54a )
	postgres? ( >=dev-db/postgresql-7.3 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )"

src_unpack() {
	unpack ${A}

	# gcc-4.3 compatibility. Fixes bug 218913.
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	python_version
	export LIBPYTHON="-lpython${PYVER} -lz"

	myconf="--with-pythondir=/usr/$(get_libdir)/python${PYVER}/\
		$(use_with mysql) \
		$(use_with firebird) \
		$(use_with odbc) \
		$(use_with postgres)"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	use doc && dohtml -r "${WORKDIR}"/${MY_P}/documentation/api
	use doc && dohtml -r "${WORKDIR}"/hk_classestutorial
	use doc && dohtml -r "${WORKDIR}"/hk_kdeclssestutorial
	use doc && dohtml -r "${WORKDIR}"/knodascriptingtutorial
	use doc && dohtml -r "${WORKDIR}"/knodatutorial
	use doc && dohtml -r "${WORKDIR}"/pythonreference

	emake DESTDIR="${D}" install || die "make install failed"
}
