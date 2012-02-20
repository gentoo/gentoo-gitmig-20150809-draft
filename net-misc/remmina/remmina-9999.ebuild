# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/remmina/remmina-9999.ebuild,v 1.12 2012/02/20 00:51:14 floppym Exp $

EAPI="4"
EGIT_REPO_URI="git://github.com/FreeRDP/Remmina.git"

inherit gnome2-utils cmake-utils git-2

DESCRIPTION="A GTK+ RDP, VNC, XDMCP and SSH client"
HOMEPAGE="http://remmina.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ayatana avahi crypt debug freerdp gnome-keyring nls ssh telepathy unique vte"

RDEPEND="x11-libs/gtk+:3
	net-libs/libvncserver
	x11-libs/libxkbfile
	gnome-keyring? ( gnome-base/libgnome-keyring )
	ayatana? ( dev-libs/libappindicator )
	avahi? ( net-dns/avahi[gtk3] )
	crypt? ( dev-libs/libgcrypt )
	freerdp? ( >=net-misc/freerdp-1.0 )
	ssh? ( net-libs/libssh[sftp] )
	telepathy? ( net-libs/telepathy-glib )
	!net-misc/remmina-plugins
	vte? ( x11-libs/vte:2.90 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( README )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with ayatana APPINDICATOR)
		$(cmake-utils_use_with avahi AVAHI)
		$(cmake-utils_use_with crypt GCRYPT)
		$(cmake-utils_use_with freerdp FREERDP)
		$(cmake-utils_use_with gnome-keyring GNOMEKEYRING)
		$(cmake-utils_use_with ssh LIBSSH)
		$(cmake-utils_use_with telepathy TELEPATHY)
		$(cmake-utils_use_with vte VTE)
		-DHAVE_PTHREAD=ON
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
