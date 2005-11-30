# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/winki/winki-0.3.11.ebuild,v 1.1.1.1 2005/11/30 09:57:32 chriswhite Exp $

inherit distutils eutils

DESCRIPTION="A Python frontend to many popular encoding programs."
HOMEPAGE="http://www.winki-the-ripper.de/"

SRC_URI="http://www.winki-the-ripper.de/share/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~ppc ~x86"
IUSE="css mastroska mp3 ogg vcd vorbis"
DEPEND=">=dev-lang/python-2.3
		>=dev-python/gnome-python-2
		>=dev-python/pygtk-2
		>=dev-python/pyorbit-2"
RDEPEND="${DEPEND}
		media-video/mplayer
		media-video/lsdvd
		ogg? (media-sound/ogmtools
			  media-sound/vorbis-tools)
		matroska? ( media-video/mkvtoolnix )
		vcd? ( media-libs/libdvb 
			   media-video/vcdimager )
		mp3? ( media-sound/lame )
		vorbis? ( media-sound/vorbis-tools )"

pkg_setup() {
	if ! use ogg && ! use matroska; then
		ewarn "You should specify either the 'ogg' (to use ogmtools)"
		ewarn "or 'matroska' (to use mkvtoolnix) USE flag. You may"
		ewarn "ignore this warning if at least one of these packages"
		ewarn "is already installed."
	fi

	if ! use vorbis && ! use mp3; then
		ewarn "You need to specify either the 'vorbis' (to use oggenc)"
		ewarn "or 'mp3' (to use lame) USE flag (or both) to enable audio"
		ewarn "encoding in Winki. You may ignore this warning if at"
		ewarn "least one of these tools is already installed."
	fi
		
	if use css && ! built_with_use mplayer dvdread; then
		ewarn "If you want CSS support in Winki, you must rebuild"
		ewarn "mplayer with the 'dvdread' USE flag."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# fixes a sandbox violation
	epatch ${FILESDIR}/${P}.patch
}
