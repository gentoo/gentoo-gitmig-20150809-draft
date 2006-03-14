# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.14.0.ebuild,v 1.1 2006/03/14 20:07:38 joem Exp $

inherit gnome2

DESCRIPTION="Multimedia related programs for the GNOME desktop"
HOMEPAGE="http://ronald.bitfreak.net/gnome-media.php"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6 mad ogg static vorbis"

RDEPEND=">=dev-libs/glib-1.3.7
	>=gnome-base/libgnomeui-2.13.2
	>=media-sound/esound-0.2.23
	>=gnome-base/libbonobo-2
	>=x11-libs/gtk+-2.6
	>=media-libs/gstreamer-0.10
	>=media-libs/gst-plugins-base-0.10
	>=media-libs/gst-plugins-good-0.10
	>=gnome-base/gnome-vfs-2
	>=gnome-base/orbit-2
	>=gnome-extra/nautilus-cd-burner-2.12
	>=gnome-base/gail-0.0.3
	>=gnome-base/libglade-1.99.12
	dev-libs/libxml2
	>=gnome-base/gconf-1.2.1
	ogg? ( >=media-plugins/gst-plugins-ogg-0.10 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10 )
	mad? ( >=media-plugins/gst-plugins-mad-0.10 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable static) --disable-esdtest"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	gnome2_omf_fix
}

src_compile() {
	addpredict "/root/.gconfd"
	addpredict "/root/.gconf"

	gnome2_src_compile
}
