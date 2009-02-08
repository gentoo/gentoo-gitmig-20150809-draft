# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.20.1.ebuild,v 1.11 2009/02/08 22:05:33 eva Exp $

inherit gnome2 eutils

DESCRIPTION="Multimedia related programs for the GNOME desktop"
HOMEPAGE="http://ronald.bitfreak.net/gnome-media.php"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="arm sh"
IUSE="esd ipv6 mad ogg vorbis"

RDEPEND=">=dev-libs/glib-1.3.7
	>=gnome-base/libgnome-2.13.7
	>=gnome-base/libgnomeui-2.13.2
	esd? ( >=media-sound/esound-0.2.23 )
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
	>=dev-util/intltool-0.35.0
	>=app-text/gnome-doc-utils-0.12.0"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable esd vumeter)
	--disable-esdtest"
}

src_unpack() {
	gnome2_src_unpack

	epatch "${FILESDIR}"/${PN}-2.18.0-noesd.patch

	# fix LINGUAS handling, bug #183086
	intltoolize --force || die "intltoolize failed"
}

src_compile() {
	addpredict "/root/.gconfd"
	addpredict "/root/.gconf"

	gnome2_src_compile
}
