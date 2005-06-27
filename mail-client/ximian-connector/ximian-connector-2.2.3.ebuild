# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/ximian-connector/ximian-connector-2.2.3.ebuild,v 1.3 2005/06/27 09:31:31 dholm Exp $

inherit gnome2 eutils

DESCRIPTION="Evolution module for connecting to Microsoft Exchange"
HOMEPAGE="http://www.novell.com/products/desktop/features/evolution.html"
LICENSE="GPL-2"

SLOT="2.0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="debug doc"

RDEPEND=">=mail-client/evolution-2.2
	>=gnome-extra/evolution-data-server-1.2
	>=net-libs/libsoup-2.2.1
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libbonobo-2.0
	dev-libs/libxml2
	>=gnome-base/gconf-2.0
	>=net-nds/openldap-2.1.30-r2
	virtual/krb5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

MAKEOPTS="${MAKEOPTS} -j1"
G2CONF="${G2CONF} `use_with debug e2k-debug`"
USE_DESTDIR="1"
