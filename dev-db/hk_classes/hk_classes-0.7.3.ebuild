# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hk_classes/hk_classes-0.7.3.ebuild,v 1.1 2005/03/22 21:58:46 carlo Exp $

inherit eutils python

P_DOCS="hk_docs-0.7"

MY_P=${P/_alpha/-test}
S=${WORKDIR}/${MY_P}

DESCRIPTION="GUI-independent C++ libraries for database applications, including API documentation and tutorials."
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="mirror://sourceforge/hk-classes/${MY_P}.tar.bz2
		 mirror://sourceforge/knoda/knodapython.tar.bz2
		 mirror://sourceforge/knoda/${P_DOCS}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="mysql postgres sqlite sqlite3 odbc doc"

# At least one of the following is required
DEPEND="mysql? ( >=dev-db/mysql-3.23.54a )
	postgres? ( >=dev-db/postgresql-7.3 )
	sqlite? ( =dev-db/sqlite-2* )
	sqlite3? ( =dev-db/sqlite-3* )
	odbc? ( >=dev-db/unixODBC-2.0.6 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	python_version
	myconf="$myconf `use_with mysql` `use_with postgres` `use_with odbc` `use_with sqlite` `use_with sqlite3`"
	myconf="$myconf --with-pythondir=/usr/lib/python${PYVER}/"
	export LIBPYTHON="-lpython${PYVER} -lz"
	econf $myconf || die "econf failed"
	emake || die
}

src_install() {
	use doc && dohtml -r ${WORKDIR}/${P_DOCS}/*
	use doc && dohtml -r ${WORKDIR}/knodapythondoc
	make DESTDIR=${D} install || die
}
