# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-data-server/evolution-data-server-0.0.99.ebuild,v 1.1 2004/09/13 21:52:50 tseng Exp $

inherit debug gnome2 libtool

DESCRIPTION="New backend for Evolution groupware"
HOMEPAGE="http://www.ximian.com/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc ldap"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/libbonobo-2.4
	>=gnome-base/orbit-2.9.8
	>=gnome-base/gnome-vfs-2.0
	>=gnome-base/libgnome-2.0
	>=gnome-base/gconf-2.0
	>=dev-libs/libxml2-2
	>=net-libs/libsoup-2.2
	ldap? ( >=net-nds/openldap-2.0 )"

DEPEND="${RDEPEND}
	dev-libs/popt
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.30
	doc? ( >=app-text/scrollkeeper-0.3.10-r1
		   >=dev-util/gtk-doc-1 )"

MAKEOPTS="${MAKEOPTS} -j1"
G2CONF="${G2CONF} \
		`use_enable doc gtk-doc` \
		`use_with ldap openldap`"
USE_DESTDIR=1
