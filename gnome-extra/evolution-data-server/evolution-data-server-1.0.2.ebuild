# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-data-server/evolution-data-server-1.0.2.ebuild,v 1.2 2004/10/17 14:45:35 liquidx Exp $

inherit gnome2

DESCRIPTION="Evolution groupware backend"
HOMEPAGE="http://www.ximian.com/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~mips ~hppa"
IUSE="doc ldap"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/libbonobo-2.4
	>=gnome-base/orbit-2.9.8
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=dev-libs/libxml2-2
	>=net-libs/libsoup-2.2.1
	ldap? ( >=net-nds/openldap-2.0 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.30
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} `use_with ldap openldap`"

MAKEOPTS="${MAKEOPTS} -j1"
USE_DESTDIR=1

src_unpack() {
	unpack ${A}
	use amd64 && rm ${S}/libdb/dbinc/mutex.h
}

src_compile() {
	cd ${S}/libdb/dist
	./s_config || die

	cd ${S}
	gnome2_src_compile
}
