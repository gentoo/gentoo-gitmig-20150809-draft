# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundconverter/soundconverter-0.9.0.ebuild,v 1.1 2006/09/03 22:52:41 hanno Exp $

inherit eutils

DESCRIPTION="A simple sound converter application for the GNOME environment."
HOMEPAGE="http://soundconverter.berlios.de/"
SRC_URI="http://download.berlios.de/soundconverter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mp3 vorbis flac"

RDEPEND="virtual/python
	>=x11-libs/gtk+-2
	>=dev-python/pygtk-2.0.0
	>=dev-python/gnome-python-2.0
	gnome-base/libglade
	gnome-base/gconf
	gnome-base/gnome-vfs
	=media-libs/gstreamer-0.10*
	=dev-python/gst-python-0.10*
	vorbis? ( =media-plugins/gst-plugins-vorbis-0.10* )
	flac? ( =media-plugins/gst-plugins-flac-0.10* )
	mp3? ( =media-plugins/gst-plugins-lame-0.10* )"

#src_unpack() {
#	unpack ${A}
#	epatch ${FILESDIR}/${PN}-0.8.6-makefile-fix.diff
##}

src_compile() {
	econf || die
	emake @@ die
}

src_install () {
	einstall || die
}
