# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/remmina/remmina-9999.ebuild,v 1.4 2012/02/12 10:46:37 hwoarang Exp $

EAPI="4"
EGIT_REPO_URI="git://github.com/FreeRDP/Remmina.git"

inherit gnome2-utils cmake-utils git-2

DESCRIPTION="A GTK+ RDP, VNC, XDMCP and SSH client"
HOMEPAGE="http://remmina.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ayatana avahi crypt debug freerdp nls ssh unique vte"

RDEPEND="x11-libs/gtk+:2
	ayatana? ( dev-libs/libappindicator )
	avahi? ( net-dns/avahi )
	crypt? ( dev-libs/libgcrypt )
	freerdp? ( net-misc/freerdp )
	ssh? ( net-libs/libssh[sftp] )
	!net-misc/remmina-plugins"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( README )

src_prepare() {
	sed -i -e "/REMMINA_PLUGINDIR/s:lib:$(get_libdir):" CMakeLists.txt || die
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with ayatana appindicator) \
		$(cmake-utils_use_with avahi) \
		$(cmake-utils_use_with crypt GCRYPT) \
		$(cmake-utils_use_with freerdp) \
		$(cmake-utils_use_with ssh LIBSSH) \
		-DHAVE_PTHREAD=ON
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	elog "You need to install net-misc/remmina-plugins which"
	elog "provide all the necessary network protocols required by ${PN}"
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
