# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/ximian-connector/ximian-connector-1.4.7.2.ebuild,v 1.5 2004/10/22 22:37:46 liquidx Exp $

inherit gnome2

DESCRIPTION="Evolution module for connecting to Microsoft Exchange"
HOMEPAGE="http://www.novell.com/products/connector/"
SRC_URI="http://ftp.ximian.com/pub/source/evolution/${PF}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE="debug doc"

RDEPEND=">=mail-client/evolution-1.4
		>=dev-libs/glib-2.0
		>=gnome-base/orbit-2.3
		>=gnome-base/gconf-2.0
		=net-libs/libsoup-1.99*
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


