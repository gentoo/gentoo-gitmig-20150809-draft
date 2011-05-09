# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr-util/apr-util-1.3.11.ebuild,v 1.1 2011/05/09 21:14:15 arfrever Exp $

EAPI="3"

# Usually apr-util has the same PV as apr, but in case of security fixes, this may change.
# APR_PV="${PV}"
APR_PV="1.4.4"

inherit autotools db-use eutils libtool multilib

DESCRIPTION="Apache Portable Runtime Utility Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="berkdb doc freetds gdbm ldap mysql odbc postgres sqlite sqlite3"
RESTRICT="test"

RDEPEND="dev-libs/expat
	>=dev-libs/apr-${APR_PV}:1
	berkdb? ( >=sys-libs/db-4 )
	freetds? ( dev-db/freetds )
	gdbm? ( sys-libs/gdbm )
	ldap? ( =net-nds/openldap-2* )
	mysql? ( =virtual/mysql-5* )
	odbc? ( dev-db/unixODBC )
	postgres? ( dev-db/postgresql-base )
	sqlite? ( dev-db/sqlite:0 )
	sqlite3? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	eautoreconf

	elibtoolize
}

src_configure() {
	local myconf

	if use berkdb; then
		local db_version
		db_version="$(db_findver sys-libs/db)" || die "Unable to find Berkeley DB version"
		db_version="$(db_ver_to_slot "${db_version}")"
		db_version="${db_version/\./}"
		myconf+=" --with-dbm=db${db_version} --with-berkeley-db=$(db_includedir 2> /dev/null):/usr/$(get_libdir)"
	else
		myconf+=" --without-berkeley-db"
	fi

	econf --datadir=/usr/share/apr-util-1 \
		--with-apr=/usr \
		--with-expat=/usr \
		$(use_with freetds) \
		$(use_with gdbm) \
		$(use_with ldap) \
		$(use_with mysql) \
		$(use_with odbc) \
		$(use_with postgres pgsql) \
		$(use_with sqlite sqlite2) \
		$(use_with sqlite3) \
		${myconf}
}

src_compile() {
	emake CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"

	if use doc; then
		emake dox || die "emake dox failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	find "${ED}" -name "*.la" -print0 | xargs -0 rm -f
	find "${ED}usr/$(get_libdir)/apr-util-${SLOT}" -name "*.a" -print0 | xargs -0 rm -f

	dodoc CHANGES NOTICE README

	if use doc; then
		dohtml -r docs/dox/html/* || die "dohtml failed"
	fi

	# This file is only used on AIX systems, which Gentoo is not,
	# and causes collisions between the SLOTs, so remove it.
	rm -f "${D}usr/$(get_libdir)/aprutil.exp"
}
