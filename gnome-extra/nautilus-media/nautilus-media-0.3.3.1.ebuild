# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-media/nautilus-media-0.3.3.1.ebuild,v 1.1 2003/09/10 22:45:45 foser Exp $

inherit gnome2

DESCRIPTION="Media plugins for Nautilus (audio view and info tab)"
HOMEPAGE="http://www.gstreamer.net"

IUSE="oggvorbis mad"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64"

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.2
	>=media-libs/gstreamer-0.6.3
	>=media-libs/gst-plugins-0.6.3
	>=media-libs/gst-plugins-gnomevfs-0.6.3
	oggvorbis? ( >=media-libs/gst-plugins-vorbis-0.6.3 )
	mad? ( >=media-libs/gst-plugins-mad-0.6.3 )"

# FIXME : flac support dep (?)

DEPEND=">=dev-util/intltool-0.18
	>=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README TODO"
