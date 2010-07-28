# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/lat/lat-1.2.3.ebuild,v 1.3 2010/07/28 13:00:06 flameeyes Exp $

EAPI=2

GCONF_DEBUG=no

inherit gnome2 mono versionator

KEYWORDS="~amd64 ~x86"

DESCRIPTION="LDAP Administration Tool, allows you to browse LDAP-based directories and add/edit/delete entries."
HOMEPAGE="http://sourceforge.net/projects/ldap-at/"
SRC_URI="mirror://sourceforge/ldap-at/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="avahi"
SLOT="0"

RDEPEND=">=dev-lang/mono-1.1.13
	>=dev-dotnet/gtk-sharp-2.8
	>=dev-dotnet/gnome-sharp-2.8
	|| ( dev-dotnet/gtk-sharp[glade] >=dev-dotnet/glade-sharp-2.8 )
	>=dev-dotnet/gconf-sharp-2.8
	>=gnome-base/gnome-keyring-0.4
	sys-apps/dbus
	avahi? ( net-dns/avahi )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable avahi) \
		|| die "econf failed"
}

src_compile() {
	# bug #330203
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use avahi ; then
		ewarn "You've enabled avahi support."
		ewarn "Make sure the avahi daemon is running before you try to start ${PN}"
	fi
}
