# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sound-juicer/sound-juicer-0.4.1.ebuild,v 1.1 2003/07/04 21:50:45 liquidx Exp $

inherit gnome2

DESCRIPTION="CD ripper for GNOME 2"
HOMEPAGE="http://www.burtonini.com/"
SRC_URI="http://www.burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

# change to gst-plugins-cdparanoia when we switch to new gst format
RDEPEND=">=dev-libs/glib-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=media-libs/gstreamer-0.6.1
	>=media-libs/gst-plugins-0.6.1
	>=media-libs/musicbrainz-2.0.1"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"

# needed to get around some sandboxing checks
export GST_INSPECT=/bin/true
