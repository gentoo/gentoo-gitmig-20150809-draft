# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/acast/acast-0.18.ebuild,v 1.1 2005/03/16 20:06:40 zaheerm Exp $
inherit gnome2

DESCRIPTION="Webcasting app for GNOME"
HOMEPAGE="http://zaheer.merali.org/mediawiki/index.php/Acast"
SRC_URI="http://live.hujjat.org/acast/${P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc ~amd64"
IUSE="oggvorbis encode gnome"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	>=gnome-base/gnome-vfs-2
	>=media-libs/gstreamer-0.8.9
	>=media-libs/gst-plugins-0.8.8
	>=media-plugins/gst-plugins-gnomevfs-0.8.8
	>=media-plugins/gst-plugins-shout2-0.8.8
	oggvorbis? ( >=media-plugins/gst-plugins-vorbis-0.8.8
	             >=media-plugins/gst-plugins-ogg-0.8.8 )
	encode? ( >=media-plugins/gst-plugins-lame-0.8.8 )
	gnome? ( >=gnome-base/libgnomeui-2.6.0
	         >=gnome-extra/gnome-media-2.6.0 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	app-text/scrollkeeper"

DOCS="AUTHORS COPYING ChangeLog INSTALL \
	  NEWS README TODO"

G2CONF=`use_enable gnome`
