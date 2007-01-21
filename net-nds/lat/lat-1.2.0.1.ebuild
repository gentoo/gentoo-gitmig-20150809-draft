# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/lat/lat-1.2.0.1.ebuild,v 1.2 2007/01/21 20:01:28 bass Exp $

inherit gnome2 mono versionator eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="LDAP Administration Tool, allows you to browse LDAP-based directories and add/edit/delete entries."
HOMEPAGE="http://dev.mmgsecurity.com/projects/lat"
SRC_URI="http://dev.mmgsecurity.com/downloads/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="avahi"
SLOT="0"

RDEPEND=">=dev-lang/mono-1.1.13
	>=dev-dotnet/gtk-sharp-2.8
	>=dev-dotnet/gnome-sharp-2.8
	>=dev-dotnet/glade-sharp-2.8
	>=dev-dotnet/gconf-sharp-2.8
	>=gnome-base/gnome-keyring-0.4
	sys-apps/dbus
	avahi? ( net-dns/avahi )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use sys-apps/dbus mono ; then
		echo
		eerror "You need mono support in dbus"
		die "dbust is missing mono binding."
	fi
}

src_compile() {
	econf \
		$(use_enable avahi) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	if use avahi ; then
		ewarn "You've enabled avahi support."
		ewarn "Make sure the avahi daemon is running before you try to start ${PN}"
	fi
}
