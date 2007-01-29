# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgda/libgda-2.99.3.ebuild,v 1.1 2007/01/29 22:48:44 leonardop Exp $

# TODO:
# * Verify if the parallel compilation problems persist, and if so fix them.

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="2.5"

inherit autotools eutils mono gnome2

DESCRIPTION="Gnome Database Access Library"
HOMEPAGE="http://www.gnome-db.org/"
LICENSE="GPL-2 LGPL-2"

IUSE="berkdb doc firebird freetds ldap mdb mono mysql oci8 odbc postgres xbase"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=dev-libs/glib-2.8
	>=dev-libs/libxml2-2
	virtual/fam
	sys-libs/readline
	sys-libs/ncurses
	dev-libs/popt
	berkdb?   ( sys-libs/db )
	odbc?     ( >=dev-db/unixODBC-2.0.6 )
	mysql?    ( virtual/mysql )
	postgres? ( >=dev-db/libpq-7.2.1 )
	freetds?  ( >=dev-db/freetds-0.62 )
	firebird? ( dev-db/firebird )
	xbase?    ( dev-db/xbase )
	mdb?      ( >=app-office/mdbtools-0.5 )
	ldap?     ( >=net-nds/openldap-2.0.25 )
	mono? (
		>=dev-lang/mono-1
		>=dev-dotnet/gtk-sharp-2.3.90 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.30
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

# problems with parallel builds
MAKEOPTS="${MAKEOPTS} -j1"


pkg_setup() {
	G2CONF="$(use_enable mono csharp) \
		$(use_with berkdb bdb /usr)        \
		$(use_with odbc odbc /usr)         \
		$(use_with mysql mysql /usr)       \
		$(use_with postgres postgres /usr) \
		$(use_with freetds tds /usr)       \
		$(use_with firebird firebird /usr) \
		$(use_with xbase xbase /usr)       \
		$(use_with mdb mdb /usr)           \
		$(use_with ldap ldap /usr)"

	use oci8 || G2CONF="${G2CONF} --without-oracle"

	# Not in portage
	G2CONF="${G2CONF} --without-mSQL --without-sybase --without-ibmdb2"
}

src_unpack() {
	gnome2_src_unpack

	# Fix compilation of the mdb provider
	epatch "${FILESDIR}/${PN}-1.2.3-mdb_api.patch"

	# Avoid collisions with libgda-1.2.x
	epatch "${FILESDIR}/${P}-collisions.patch"
	mv -f ${S}/tools/gda-config.5 ${S}/tools/gda-config-3.0.5
	mv -f ${S}/tools/gda-config-tool.1 ${S}/tools/gda-config-tool-3.0.1
	mv -f ${S}/doc/C/libgda-docs.sgml ${S}/doc/C/libgda-3.0-docs.sgml
	mv -f ${S}/doc/C/libgda-overrides.txt ${S}/doc/C/libgda-3.0-overrides.txt
	mv -f ${S}/doc/C/libgda-sections.txt ${S}/doc/C/libgda-3.0-sections.txt
	mv -f ${S}/doc/C/libgda.types ${S}/doc/C/libgda-3.0.types

	sed -n -e '/GTK_DOC_CHECK/,/IT_PROG_INTLTOOL/p' aclocal.m4 > gtk-doc.m4
	intltoolize --automake -c -f || die "intltoolize failed"
	AT_M4DIR="." eautoreconf
}
