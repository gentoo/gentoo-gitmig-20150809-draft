# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgda/libgda-3.0.4.ebuild,v 1.2 2008/05/19 19:57:54 dev-zero Exp $

# TODO:
# * Verify if the parallel compilation problems persist, and if so fix them.

inherit db-use flag-o-matic gnome2

DESCRIPTION="Gnome Database Access Library"
HOMEPAGE="http://www.gnome-db.org/"
LICENSE="GPL-2 LGPL-2"

# MDB support currently works with CVS only, so disable it in the meantime
IUSE="berkdb bindist doc firebird freetds ldap mysql oci8 odbc postgres xbase"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=dev-libs/glib-2.8
	>=dev-libs/libxml2-2
	virtual/fam
	sys-libs/readline
	sys-libs/ncurses
	berkdb?   ( sys-libs/db )
	odbc?     ( >=dev-db/unixODBC-2.0.6 )
	mysql?    ( virtual/mysql )
	postgres? ( >=virtual/postgresql-base-7.2.1 )
	freetds?  ( >=dev-db/freetds-0.62 )
	!bindist? ( firebird? ( dev-db/firebird ) )
	xbase?    ( dev-db/xbase )
	ldap?     ( >=net-nds/openldap-2.0.25 )"
#	mdb?      ( >app-office/mdbtools-0.5 )

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.30
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

# problems with parallel builds
MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	G2CONF="$(use_with berkdb bdb /usr) \
		$(use_with odbc odbc /usr)         \
		$(use_with mysql mysql /usr)       \
		$(use_with postgres postgres /usr) \
		$(use_with freetds tds /usr)       \
		$(use_with xbase xbase /usr)       \
		$(use_with ldap ldap /usr)         \
		--without-mdb"
#		$(use_with mdb mdb /usr)           \

	if use bindist; then
		# firebird license is not GPL compatible
		G2CONF="${G2CONR} --without-firebird"
	else
		G2CONF="${G2CONR} $(use_with firebird firebird /usr)"
	fi

	use berkdb && append-cppflags "-I$(db_includedir)"
	use oci8 || G2CONF="${G2CONF} --without-oracle"

	# Not in portage
	G2CONF="${G2CONF} --without-mSQL --without-sybase --without-ibmdb2"
}
