# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr-util/apr-util-1.2.10.ebuild,v 1.1 2007/09/08 20:06:43 hollow Exp $

inherit autotools eutils flag-o-matic libtool db-use

DBD_MYSQL=84
APR_PV=1.2.11

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.gz
	mirror://apache/apr/apr-${APR_PV}.tar.gz
	mysql? ( mirror://gentoo/apr_dbd_mysql-r${DBD_MYSQL}.c )"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="berkdb gdbm ldap mysql postgres sqlite sqlite3"
RESTRICT="test"

DEPEND="dev-libs/expat
	>=dev-libs/apr-${PV}
	berkdb? ( =sys-libs/db-4* )
	gdbm? ( sys-libs/gdbm )
	ldap? ( =net-nds/openldap-2* )
	mysql? ( =virtual/mysql-5* )
	postgres? ( dev-db/libpq )
	sqlite? ( =dev-db/sqlite-2* )
	sqlite3? ( =dev-db/sqlite-3* )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use mysql ; then
		cp "${DISTDIR}"/apr_dbd_mysql-r${DBD_MYSQL}.c \
			"${S}"/dbd/apr_dbd_mysql.c || die "could not copy mysql driver"
	fi

	./buildconf --with-apr=../apr-${APR_PV} || die "buildconf failed"
	elibtoolize || die "elibtoolize failed"
}

src_compile() {
	local myconf=""

	use ldap && myconf="${myconf} --with-ldap"

	if use berkdb; then
		dbver="$(db_findver sys-libs/db)" || die "Unable to find db version"
		dbver="$(db_ver_to_slot "$dbver")"
		dbver="${dbver/\./}"
		myconf="${myconf} --with-dbm=db${dbver}
		--with-berkeley-db=$(db_includedir):/usr/$(get_libdir)"
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	econf --datadir=/usr/share/apr-util-1 \
		--with-apr=/usr \
		--with-expat=/usr \
		$(use_with gdbm) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		$(use_with sqlite sqlite2) \
		$(use_with sqlite3) \
		${myconf} || die "econf failed!"

	emake || die "emake failed!"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc CHANGES NOTICE

	# This file is only used on AIX systems, which gentoo is not,
	# and causes collisions between the SLOTs, so kill it
	rm "${D}"/usr/$(get_libdir)/aprutil.exp
}
