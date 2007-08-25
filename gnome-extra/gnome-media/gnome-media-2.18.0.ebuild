# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.18.0.ebuild,v 1.10 2007/08/25 14:21:08 vapier Exp $

inherit gnome2

DESCRIPTION="Multimedia related programs for the GNOME desktop"
HOMEPAGE="http://ronald.bitfreak.net/gnome-media.php"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE="ipv6 mad ogg vorbis"

RDEPEND=">=dev-libs/glib-1.3.7
	>=gnome-base/libgnome-2.13.7
	>=gnome-base/libgnomeui-2.13.2
	>=media-sound/esound-0.2.23
	>=gnome-base/libbonobo-2
	>=x11-libs/gtk+-2.10
	>=media-libs/gstreamer-0.10.3
	>=media-libs/gst-plugins-base-0.10.3
	>=media-libs/gst-plugins-good-0.10
	>=gnome-base/gnome-vfs-2
	>=gnome-base/orbit-2
	>=gnome-extra/nautilus-cd-burner-2.12
	>=gnome-base/gail-0.0.3
	>=gnome-base/libglade-2
	dev-libs/libxml2
	>=gnome-base/gconf-2
	ogg? ( >=media-plugins/gst-plugins-ogg-0.10 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10 )
	mad? ( >=media-plugins/gst-plugins-mad-0.10 )
	>=media-plugins/gst-plugins-gconf-0.10.1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.35.0"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable ipv6) --disable-esdtest"
}

src_compile() {
	addpredict "/root/.gconfd"
	addpredict "/root/.gconf"

	gnome2_src_compile
}
