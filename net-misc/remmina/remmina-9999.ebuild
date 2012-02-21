# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/remmina/remmina-9999.ebuild,v 1.16 2012/02/21 15:59:04 floppym Exp $

EAPI="4"
EGIT_REPO_URI="git://github.com/FreeRDP/Remmina.git"

inherit gnome2-utils cmake-utils git-2

DESCRIPTION="A GTK+ RDP, VNC, XDMCP and SSH client"
HOMEPAGE="http://remmina.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ayatana avahi crypt debug freerdp gnome-keyring +gtk3 nls ssh telepathy vte"

RDEPEND="
	net-libs/libvncserver
	x11-libs/libxkbfile
	gnome-keyring? ( gnome-base/libgnome-keyring )
	crypt? ( dev-libs/libgcrypt )
	freerdp? ( >=net-misc/freerdp-1.0 )
	gtk3? ( x11-libs/gtk+:3
		avahi? ( net-dns/avahi[gtk3] )
		ayatana? ( dev-libs/libappindicator )
		vte? ( x11-libs/vte:2.90 )
	)
	!gtk3? ( x11-libs/gtk+:2
		avahi? ( net-dns/avahi[gtk] )
		vte? ( x11-libs/vte:0 )
	)
	ssh? ( net-libs/libssh[sftp] )
	telepathy? ( net-libs/telepathy-glib )
	!net-misc/remmina-plugins
"
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
		-DGTK_VERSION=$(use gtk3 && echo 3 || echo 2)
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
