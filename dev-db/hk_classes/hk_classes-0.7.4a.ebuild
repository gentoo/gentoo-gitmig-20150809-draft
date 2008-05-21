# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hk_classes/hk_classes-0.7.4a.ebuild,v 1.8 2008/05/21 15:54:06 dev-zero Exp $

inherit eutils python

P_DOCS="hk_classes-htmldocumentation-0.7.3"

MY_P=${P/_alpha/-test}
S=${WORKDIR}/${MY_P}

DESCRIPTION="GUI-independent C++ libraries for database applications, including API documentation and tutorials."
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="mirror://sourceforge/hk-classes/${MY_P}.tar.bz2
	doc? ( mirror://sourceforge/knoda/${P_DOCS}.tar.bz2 )"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc firebird mysql odbc postgres sqlite sqlite3"

# pxlib is not in portage yet, but there's no reason not add paradox
# (readonly) support by request - speak: if you really need it

# with mdb and xbase will be dealt in another revision

RDEPEND="firebird? ( dev-db/firebird )
	mysql? ( virtual/mysql )
	postgres? ( >=virtual/postgresql-server-7.3 )
	sqlite? ( =dev-db/sqlite-2* )
	sqlite3? ( =dev-db/sqlite-3* )
	odbc? ( >=dev-db/unixODBC-2.0.6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-amd64.patch

	if use doc ; then
		cd ${WORKDIR}
		local docdirs="`ls -1`"
		mkdir ${P_DOCS}
		for I in "${docdirs/${P}/}" ; do
			mv ${I} ${P_DOCS}
		done
		find ${P_DOCS} -iname CVS -type d -exec rm -rf '{}' \; 2> /dev/null
	fi
}

src_compile() {
	python_version
	export LIBPYTHON="-lpython${PYVER} -lz"

	myconf="--with-pythondir=/usr/$(get_libdir)/python${PYVER}/\
		`use_with mysql`\
		`use_with firebird`\
		`use_with odbc`\
		`use_with postgres`\
		`use_with sqlite`\
		`use_with sqlite3`\
		--without-mdb --without-paradox --without-xbase"

	econf ${myconf} || die "econf failed"
	emake || die "make failes"
}

src_install() {
	use doc && dohtml -r ${WORKDIR}/${P_DOCS}/*
	make DESTDIR=${D} install || die "make install failed"
}
