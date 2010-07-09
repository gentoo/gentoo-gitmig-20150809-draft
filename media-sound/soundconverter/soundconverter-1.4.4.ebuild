# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundconverter/soundconverter-1.4.4.ebuild,v 1.3 2010/07/09 15:25:44 pacho Exp $

inherit gnome2

DESCRIPTION="A simple sound converter application for the GNOME environment."
HOMEPAGE="http://soundconverter.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="aac flac mp3 vorbis"

RDEPEND=">=dev-python/pygtk-2.12
	>=dev-python/gnome-python-2.12
	gnome-base/libglade
	gnome-base/gconf
	=dev-python/gst-python-0.10*
	=media-plugins/gst-plugins-gnomevfs-0.10*
	vorbis? (
		=media-plugins/gst-plugins-vorbis-0.10*
		=media-plugins/gst-plugins-ogg-0.10*
	)
	mp3? (
		=media-plugins/gst-plugins-lame-0.10*
		=media-plugins/gst-plugins-mad-0.10*
		=media-plugins/gst-plugins-taglib-0.10*
	)
	flac? ( =media-plugins/gst-plugins-flac-0.10* )
	aac? ( =media-plugins/gst-plugins-faac-0.10* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

DOCS="AUTHORS ChangeLog README TODO"
