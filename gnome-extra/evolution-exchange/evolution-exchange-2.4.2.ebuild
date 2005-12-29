# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-exchange/evolution-exchange-2.4.2.ebuild,v 1.2 2005/12/29 23:16:03 dang Exp $

inherit gnome2 eutils

DESCRIPTION="Evolution module for connecting to Microsoft Exchange"
HOMEPAGE="http://www.novell.com/products/desktop/features/evolution.html"
LICENSE="GPL-2"

SLOT="2.0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug doc"

RDEPEND=">=mail-client/evolution-2.3
	>=gnome-extra/evolution-data-server-1.2
	>=net-libs/libsoup-2.2
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
USE_DESTDIR="1"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with debug e2k-debug) --with-krb5=/usr"

	if ! built_with_use gnome-extra/evolution-data-server ldap || ! built_with_use gnome-extra/evolution-data-server kerberos; then
		eerror "Please re-emerge gnome-extra/evolution-data-server with"
		eerror "the use flags ldap and kerberos."
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-2.4.0-kerb.patch

	automake
	autoconf
}
