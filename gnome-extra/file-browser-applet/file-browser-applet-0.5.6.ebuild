# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/file-browser-applet/file-browser-applet-0.5.6.ebuild,v 1.1 2008/06/08 17:31:02 serkan Exp $

inherit gnome2 cmake-utils

DESCRIPTION="Browse and open files in your home directory from the GNOME panel."
HOMEPAGE="http://code.google.com/p/gnome-menu-file-browser-applet/"
SRC_URI="http://gnome-menu-file-browser-applet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12
	>=gnome-base/gnome-vfs-2.0
	>=gnome-base/gnome-panel-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/gnome-desktop-2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	mycmakeargs="${mycmakeargs} -DCMAKE_INSTALL_GCONF_SCHEMA_DIR=/etc/gconf/schemas"
	cmake-utils_src_compile
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	cmake-utils_src_install
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc HISTORY README
}
