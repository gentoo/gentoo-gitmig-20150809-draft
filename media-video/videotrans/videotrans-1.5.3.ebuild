# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/videotrans/videotrans-1.5.3.ebuild,v 1.1 2007/09/07 12:12:28 sbriesen Exp $

inherit eutils

DESCRIPTION="A package to convert movies to DVD format and to build DVDs with."
HOMEPAGE="http://videotrans.sourceforge.net/"
SRC_URI="mirror://sourceforge/videotrans/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND="media-video/ffmpeg
	media-video/mplayer
	media-video/mjpegtools
	media-video/dvdauthor
	media-gfx/imagemagick"

RDEPEND="${DEPEND}
	www-client/lynx
	app-shells/bash
	sys-devel/bc"

pkg_setup() {
	if ! built_with_use media-video/mjpegtools png; then
		eerror "Please emerge media-video/mjpegtools with useflag 'png'."
		die "Fix USE flags and re-emerge"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# replace non-existing 'md5' with 'md5sum' (works also)
	sed -i -e 's:md5 <:md5sum <:g' src/movie-compare-dvd
}

src_install() {
	emake prefix="${D}usr" DATADIR="${D}usr/share" \
		MANDIR="${D}usr/share/man" install || die "emake install failed"

	dodoc CHANGES THANKS TODO aspects.txt
}
