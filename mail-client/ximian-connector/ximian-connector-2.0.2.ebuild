# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/ximian-connector/ximian-connector-2.0.2.ebuild,v 1.2 2004/10/22 22:37:46 liquidx Exp $

inherit gnome2 eutils

DESCRIPTION="Evolution module for connecting to Microsoft Exchange"
HOMEPAGE="http://www.novell.com/products/connector/"
LICENSE="GPL-2"

SLOT="2.0"
KEYWORDS="~x86 ~sparc"
IUSE="debug doc"

RDEPEND=">=mail-client/evolution-2.0.2
		>=dev-libs/glib-2.0
		>=gnome-base/orbit-2.3
		>=gnome-base/gconf-2.0
		>=net-libs/libsoup-2.2.1
		>=gnome-base/libglade-2.0
		>=gnome-base/libgnomeui-2.0
		>=gnome-base/libbonobo-2.0
		>=net-nds/openldap-2.1.30-r2
		virtual/krb5"

DEPEND="${RDEPEND}
		dev-util/intltool
		dev-util/pkgconfig
		doc? ( dev-util/gtk-doc )"

MAKEOPTS="${MAKEOPTS} -j1"
G2CONF="${G2CONF} `use_with debug e2k-debug`"
USE_DESTDIR="1"
