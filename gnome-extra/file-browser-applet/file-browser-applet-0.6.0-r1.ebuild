# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/file-browser-applet/file-browser-applet-0.6.0-r1.ebuild,v 1.5 2009/04/20 20:30:48 maekke Exp $

inherit gnome2 cmake-utils

DESCRIPTION="Browse and open files in your home directory from the GNOME panel."
HOMEPAGE="http://code.google.com/p/gnome-menu-file-browser-applet/"
SRC_URI="http://gnome-menu-file-browser-applet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtkhotkey"

RDEPEND=">=x11-libs/gtk+-2.14
	>=gnome-base/gnome-panel-2.0
	>=gnome-base/libglade-2.0
	>=dev-libs/glib-2.16
	gtkhotkey? ( x11-libs/gtkhotkey )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/cmake-2.4.8"

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	epatch "${FILESDIR}"/${P}-fixautomagic-gtkhotkey.patch
	#Move to src_prepare when portage-2.2 is stable.
}

src_compile() {
	mycmakeargs="${mycmakeargs} -DCMAKE_INSTALL_GCONF_SCHEMA_DIR=/etc/gconf/schemas"
	use gtkhotkey || mycmakeargs="${mycmakeargs} -DDISABLE_GTK_HOTKEY=true"
	cmake-utils_src_compile
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	cmake-utils_src_install
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc HISTORY README || die "dodoc failed"
}
