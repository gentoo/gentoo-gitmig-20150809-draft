# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $header :$

# debug since its still in devel 
inherit gnome2 debug

DESCRIPTION="GStreamer Media Player"
HOMEPAGE="http://www.gstreamer.net/apps/gst-player/"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.6.1
	>=media-libs/gst-plugins-0.6.1
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libglade-2
	dev-libs/libxml2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21"

DOCS="AUTHORS ChangeLog INSTALL NEWS README RELEASE TODO"

SCROLLKEEPER_UPDATE="0"
