# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.6.0.ebuild,v 1.1 2004/03/28 22:43:06 foser Exp $

inherit gnome2

DESCRIPTION="Multimedia related programs for the Gnome2 desktop"
HOMEPAGE="http://www.prettypeople.org/~iain/gnome-media/"

IUSE="oggvorbis mad"
LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~hppa ~ia64 ~mips"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.3.1
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2.1
	>=gnome-base/gnome-desktop-2
	>=gnome-base/gnome-vfs-2
	dev-libs/libxml2
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libbonobo-2
	>=gnome-base/gail-0.0.3
	>=media-sound/esound-0.2.23
	>=media-libs/gstreamer-0.8
	>=media-libs/gst-plugins-0.8
	oggvorbis? ( >=media-plugins/gst-plugins-vorbis-0.8
		>=media-plugins/gst-plugins-ogg-0.8 )
	mad? ( >=media-plugins/gst-plugins-mad-0.8 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.29"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"

USE_DESTDIR="1"
