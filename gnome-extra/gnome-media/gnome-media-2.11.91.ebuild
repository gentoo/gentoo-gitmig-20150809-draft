# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.11.91.ebuild,v 1.1 2005/08/23 04:30:02 leonardop Exp $

inherit gnome2

DESCRIPTION="Multimedia related programs for the GNOME desktop"
HOMEPAGE="http://ronald.bitfreak.net/gnome-media.php"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6 mad ogg static vorbis"

RDEPEND=">=dev-libs/glib-1.3.7
	>=gnome-base/libgnomeui-1.102
	>=media-sound/esound-0.2.23
	>=gnome-base/libbonobo-2
	>=x11-libs/gtk+-2.6
	>=media-libs/gstreamer-0.8.2
	>=media-libs/gst-plugins-0.8.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/orbit-2
	>=gnome-extra/nautilus-cd-burner-2.9
	>=gnome-base/gail-0.0.3
	>=gnome-base/libglade-1.99.12
	dev-libs/libxml2
	>=gnome-base/gconf-1.2.1
	>=media-plugins/gst-plugins-cdparanoia-0.8.2
	ogg? ( >=media-plugins/gst-plugins-ogg-0.8.2 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.8.2 )
	mad? ( >=media-plugins/gst-plugins-mad-0.8.2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable ipv6) $(use_enable static) --disable-esdtest"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	local makefiles=""
	for f in \
	$(find gnome-cd/doc grecord/doc gst-mixer/doc \
	gstreamer-properties/help -name Makefile.in); do
		makefiles="${makefiles} $f"
	done
	gnome2_omf_fix $makefiles
}
