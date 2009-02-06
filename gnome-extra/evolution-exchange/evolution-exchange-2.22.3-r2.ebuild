# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-exchange/evolution-exchange-2.22.3-r2.ebuild,v 1.5 2009/02/06 03:09:01 jer Exp $
EAPI="1"

inherit gnome2 eutils

DESCRIPTION="Evolution module for connecting to Microsoft Exchange"
HOMEPAGE="http://www.novell.com/products/desktop/features/evolution.html"
LICENSE="GPL-2"

SLOT="2.0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="debug doc static"

RDEPEND="
	>=mail-client/evolution-2.22.0
	>=dev-libs/glib-2.15.3
	>=x11-libs/gtk+-2.10
	>=gnome-base/gconf-2.0
	>=gnome-base/libbonobo-2.20.3
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	dev-libs/libxml2
	net-libs/libsoup:2.4
	>=gnome-extra/evolution-data-server-2.22.3
	>=net-nds/openldap-2.1.30-r2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with debug e2k-debug)"

	if ! built_with_use gnome-extra/evolution-data-server ldap || ! built_with_use gnome-extra/evolution-data-server kerberos; then
		eerror "Please re-emerge gnome-extra/evolution-data-server with"
		eerror "the use flags ldap and kerberos."
		die
	fi

	G2CONF="${G2CONF} $(use_with static static-ldap) --with-openldap"
}

src_unpack() {
	gnome2_src_unpack

	# Fix addressbook crash, bug #233263
	epatch "${FILESDIR}/${P}-addressbook-crash.patch"

	# Fix exchange contacts tracking, upstream bug #546934
	epatch "${FILESDIR}/${P}-exchange-contact.patch"
}
