# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-media/nautilus-media-0.8.0.ebuild,v 1.1 2004/03/30 20:55:52 foser Exp $

inherit gnome2

DESCRIPTION="Media plugins for Nautilus (audio view and info tab)"
HOMEPAGE="http://www.gstreamer.net"

IUSE="oggvorbis mad"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2
	>=media-libs/gstreamer-0.8
	>=media-libs/gst-plugins-0.8
	>=media-plugins/gst-plugins-gnomevfs-0.8
	>=media-plugins/gst-plugins-libpng-0.8
	oggvorbis? ( >=media-plugins/gst-plugins-vorbis-0.8
		>=media-plugins/gst-plugins-ogg-0.8 )
	mad? ( >=media-plugins/gst-plugins-mad-0.8 )"
# FIXME : flac support dep (?)

DEPEND=">=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README TODO"
