# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/remmina/remmina-1.0.0-r1.ebuild,v 1.9 2012/05/05 03:20:42 jdhore Exp $

EAPI="4"

inherit gnome2-utils cmake-utils

DESCRIPTION="A GTK+ RDP, VNC, XDMCP and SSH client"
HOMEPAGE="http://remmina.sourceforge.net/"
SRC_URI="mirror://github/FreeRDP/Remmina/Remmina-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ayatana avahi crypt debug freerdp gnome-keyring nls ssh telepathy vte"

# net-libs/libvncserver is bundled; add dep for next release
RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libxkbfile
	avahi? ( net-dns/avahi[gtk3] )
	ayatana? ( dev-libs/libappindicator )
	crypt? ( dev-libs/libgcrypt )
	freerdp? ( >=net-misc/freerdp-1.0 )
	gnome-keyring? ( gnome-base/libgnome-keyring )
	ssh? ( net-libs/libssh[sftp] )
	telepathy? ( net-libs/telepathy-glib )
	vte? ( x11-libs/vte:2.90 )
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"
RDEPEND+="
	!net-misc/remmina-plugins
"

DOCS=( README )

src_unpack() {
	default
	mv FreeRDP-Remmina-* "${S}" || die
}

src_prepare() {
	epatch "${FILESDIR}/${P}-desktop-file.patch"
	epatch "${FILESDIR}/${P}-fix-desktop-file.patch"
	epatch "${FILESDIR}/${P}-optional-gnome-keyring.patch"
	sed -i -e "/REMMINA_PLUGINDIR/s:lib:$(get_libdir):" CMakeLists.txt || die
}

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
		-DGTK_VERSION=3
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
