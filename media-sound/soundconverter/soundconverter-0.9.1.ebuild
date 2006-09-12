# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundconverter/soundconverter-0.9.1.ebuild,v 1.2 2006/09/12 00:47:21 hanno Exp $

DESCRIPTION="A simple sound converter application for the GNOME environment."
HOMEPAGE="http://soundconverter.berlios.de/"
SRC_URI="http://download.berlios.de/soundconverter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mp3 vorbis flac"

RDEPEND=">=dev-python/pygtk-2.0.0
	>=dev-python/gnome-python-2.0
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
	)
	flac? ( =media-plugins/gst-plugins-flac-0.10* )"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
}
