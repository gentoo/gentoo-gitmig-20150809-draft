# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gst-player/gst-player-0.5.0.ebuild,v 1.3 2003/06/12 21:12:48 msterret Exp $

# debug since its still in devel 
inherit gnome2 debug

DESCRIPTION="GStreamer Media Player"
HOMEPAGE="http://www.gstreamer.net/apps/gst-player/"
# bz2 not online yet
#SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.bz2"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/gstreamer-0.5.2
	>=media-libs/gst-plugins-0.5.2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libglade-2
	dev-libs/libxml2"

RDEPEND="${DEPEND}
	>=dev-util/intltool-0.21"

DOCS="AUTHORS ChangeLog INSTALL NEWS README RELEASE TODO"
