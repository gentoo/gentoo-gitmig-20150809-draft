# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgda/libgda-1.0.2.ebuild,v 1.5 2004/01/25 21:23:05 gustavoz Exp $

IUSE="odbc postgres mysql ldap firebird freetds sqlite mdb oci8 doc"

inherit gnome2

DESCRIPTION="Gnome Database Access Library"
HOMEPAGE="http://www.gnome-db.org/"
SLOT="1"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha"

RDEPEND=">=dev-libs/glib-2.0
	>=dev-libs/libxml2-2.0
	>=dev-libs/libxslt-1.0.9
	>=gnome-base/gnome-vfs-2.0
	dev-libs/popt
	sys-libs/ncurses
	mysql? ( >=dev-db/mysql-3.23.51 )
	postgres? ( >=dev-db/postgresql-7.2.1 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	ldap? ( >=net-nds/openldap-2.0.25 )
	!ppc? ( firebird? ( >=dev-db/firebird-1.0 ) )
	freetds? ( >=dev-db/freetds-0.5 )
	sqlite? ( >=dev-db/sqlite-2.4.2 )
	!alpha? ( mdb? ( >=app-office/mdbtools-0.5 ) )"

DEPEND=">=dev-util/pkgconfig-0.8
	>=dev-util/intltool-0.22
	>=sys-devel/gettext-0.11
	app-text/scrollkeeper
	doc? ( dev-util/gtk-doc )
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

# problems with parallel builds
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix ${S}/doc/Makefile.in
	epatch ${FILESDIR}/${P}-gcc2_fix.patch
}

src_compile() {

	local myconf

	use mysql \
		&& myconf="${myconf} --with-mysql=/usr" \
		|| myconf="${myconf} --without-mysql"

	use postgres \
		&& myconf="${myconf} --with-postgres=/usr" \
		|| myconf="${myconf} --without-postgres"

	use odbc \
		&& myconf="${myconf} --with-odbc=/usr" \
		|| myconf="${myconf} --without-odbc"

	use ldap \
		&& myconf="${myconf} --with-ldap=/usr" \
		|| myconf="${myconf} --without-ldap"

	use sqlite \
		&& myconf="$myconf --with-sqlite=/usr" \
		|| myconf="$myconf --without-sqlite"

	use freetds \
		&& myconf="$myconf --with-tds=/usr" \
		|| myconf="$myconf --without-tds"

	use firebird \
		&& myconf="${myconf} --with-firebird=/usr" \
		|| myconf="${myconf} --without-firebird"

	use mdb \
		&& myconf="${myconf} --with-mdb=/usr" \
		|| myconf="${myconf} --without-mdb"

	# not in portage (http://linux.techass.com/projects/xdb/)
	myconf="${myconf} --without-xbase"
	myconf="${myconf} --without-msql"

	# closed source dbs
	myconf="${myconf} --without-ibmdb2"
	myconf="${myconf} --without-sybase"
	use oci8 || myconf="${myconf} --without-oracle"

	# workaround for readline-4.1 profile - disables building of gda-config-tool
	if has_version "=sys-libs/readline-4.1*"; then
		export CONFIG_TOOL_HEADERS="wrong"
	fi

	gnome2_src_compile ${myconf}

	unset CONFIG_TOOL_HEADERS

}
