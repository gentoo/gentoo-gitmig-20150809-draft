# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gst-player/gst-player-0.4.2.ebuild,v 1.2 2003/02/13 13:27:04 vapier Exp $

inherit gnome2

DESCRIPTION="GStreamer Media Player"
HOMEPAGE="http://www.gstreamer.net/apps/gst-player/"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/gstreamer-0.4.2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libglade-2
	>=gnome-base/eel-2
	gnome-base/gail
	dev-libs/libxml2"

S="${WORKDIR}/${P}"

src_compile() {
	econf || die "Configuration failed"
	
	emake || die "Compilation failed"
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	einstall || die "Installation failed"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	dodoc AUTHORS COPYING ChangeLog README RELEASE
}

pkg_postinst() {
	gnome2_gconf_install
}
