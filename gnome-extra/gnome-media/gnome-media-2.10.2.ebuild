# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.10.2.ebuild,v 1.9 2005/08/08 14:52:50 corsair Exp $

inherit gnome2

DESCRIPTION="Multimedia related programs for the Gnome2 desktop"
HOMEPAGE="http://www.prettypeople.org/~iain/gnome-media/"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="oggvorbis mad ipv6"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.3.1
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2.1
	>=gnome-base/gnome-desktop-2
	>=gnome-base/gnome-vfs-2
	dev-libs/libxml2
	>=gnome-base/orbit-2.4.1
	>=gnome-base/libbonobo-2
	>=gnome-base/gail-0.0.3
	>=media-sound/esound-0.2.23
	>=media-libs/gstreamer-0.8
	>=media-libs/gst-plugins-0.8.2
	>=gnome-extra/nautilus-cd-burner-2.9
	>=media-plugins/gst-plugins-cdparanoia-0.8
	oggvorbis? ( >=media-plugins/gst-plugins-vorbis-0.8.2
		>=media-plugins/gst-plugins-ogg-0.8.2 )
	mad? ( >=media-plugins/gst-plugins-mad-0.8.2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} $(use_enable ipv6) --disable-esdtest"

USE_DESTDIR="1"

src_install() {

	# fix #92920 FIXME
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/

}
