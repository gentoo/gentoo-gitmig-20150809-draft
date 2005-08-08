# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sound-juicer/sound-juicer-2.10.1.ebuild,v 1.7 2005/08/08 14:57:35 corsair Exp $

inherit gnome2

DESCRIPTION="CD ripper for GNOME 2"
HOMEPAGE="http://www.burtonini.com/blog/computers/sound-juicer/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE="vorbis flac"

RDEPEND=">=dev-libs/glib-2
	>=gnome-extra/nautilus-cd-burner-2.9
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2.9
	=media-libs/gstreamer-0.8*
	gnome-extra/gnome-media
	>=media-libs/musicbrainz-2
	=media-plugins/gst-plugins-cdparanoia-0.8*
	vorbis? ( =media-plugins/gst-plugins-vorbis-0.8*
		=media-plugins/gst-plugins-ogg-0.8* )
	flac? ( =media-plugins/gst-plugins-flac-0.8* )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=app-text/scrollkeeper-0.3.5
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

# needed to get around some sandboxing checks
export GST_INSPECT=/bin/true
