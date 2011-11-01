# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgda/libgda-4.2.10.ebuild,v 1.1 2011/11/01 11:29:34 pacho Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit db-use eutils flag-o-matic gnome2 java-pkg-opt-2

DESCRIPTION="Gnome Database Access Library"
HOMEPAGE="http://www.gnome-db.org/"
LICENSE="GPL-2 LGPL-2"

# MDB support currently works with CVS only, so disable it in the meantime
# and use libgda:5 for that support then
#
# vala support doesn't build, see upstream bug #663153
IUSE="berkdb bindist canvas doc firebird gnome-keyring gtk graphviz http +introspection json ldap mysql oci8 postgres sourceview ssl"
# vala

SLOT="4"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="
	app-text/iso-codes
	>=dev-libs/glib-2.16:2
	>=dev-libs/libxml2-2:2
	dev-libs/libxslt
	dev-libs/libunique:1
	sys-libs/readline
	sys-libs/ncurses
	>=dev-db/sqlite-3.6.22:3
	berkdb?	( sys-libs/db )
	!bindist? ( firebird? ( dev-db/firebird ) )
	gtk? (
		|| ( >=x11-libs/gtk+-2.12:2 x11-libs/gdk-pixbuf:2 )
		canvas? ( x11-libs/goocanvas:0 )
		sourceview? ( x11-libs/gtksourceview:2.0 )
		graphviz? ( media-gfx/graphviz )
	)
	gnome-keyring? ( gnome-base/libgnome-keyring )
	http?	( >=net-libs/libsoup-2.24:2.4 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.5 )
	json?	( dev-libs/json-glib )
	ldap?	( net-nds/openldap )
	mysql?	( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	ssl?	( dev-libs/openssl )"
#	vala?	( >=dev-lang/vala-0.14:0.14 )
#	mdb?	( >app-office/mdbtools-0.5 )

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.18
	>=dev-util/intltool-0.35.5
	>=app-text/gnome-doc-utils-0.9
	>=dev-util/gtk-doc-am-1
	doc? ( >=dev-util/gtk-doc-1 )"

# Tests are not really good
RESTRICT="test"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"

	if use canvas || use graphviz || use sourceview; then
		if ! use gtk; then
			ewarn "You must enable USE=gtk to make use of canvas, graphivz or sourceview USE flag."
			ewarn "Disabling for now."
			G2CONF="${G2CONF} --without-goocanvas --without-graphivz --without-gtksourceview"
		else
			G2CONF="${G2CONF}
				$(use_with canvas goocanvas)
				$(use_with graphviz)
				$(use_with sourceview gtksourceview)"
		fi
	fi

	G2CONF="${G2CONF}
		--with-unique
		--disable-scrollkeeper
		--disable-static
		--enable-system-sqlite
		$(use_with berkdb bdb /usr)
		$(use_with gnome-keyring)
		$(use_with gtk ui)
		$(use_with http libsoup)
		$(use_enable introspection)
		$(use_enable introspection gda-gi)
		$(use_enable introspection gdaui-gi)
		$(use_with java java $JAVA_HOME)
		$(use_enable json)
		$(use_with ldap)
		$(use_with mysql mysql /usr)
		$(use_with postgres postgres /usr)
		$(use_enable ssl crypto)
		--disable-vala
		--without-mdb"
#		VALAC=$(type -p valac-0.14)"
#		$(use_with mdb mdb /usr)

	if use bindist; then
		# firebird license is not GPL compatible
		G2CONF="${G2CONF} --without-firebird"
	else
		G2CONF="${G2CONF} $(use_with firebird firebird /usr)"
	fi

	use berkdb && append-cppflags "-I$(db_includedir)"
	use oci8 || G2CONF="${G2CONF} --without-oracle"

	# Not in portage
	G2CONF="${G2CONF}
		--disable-default-binary"

	export XDG_DATA_HOME="${T}/.local"
}

src_prepare() {
	gnome2_src_prepare

	# Fix compilation failure of keyword_hash.c, upstream #630959
	epatch "${FILESDIR}/${PN}-4.2.0-missing-include-in-keyword_hash-generator.patch"
}
