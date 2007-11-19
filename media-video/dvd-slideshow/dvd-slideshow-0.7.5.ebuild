# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvd-slideshow/dvd-slideshow-0.7.5.ebuild,v 1.5 2007/11/19 20:00:28 aballier Exp $

inherit eutils

DESCRIPTION="DVD Slideshow - Turn your pictures into a dvd with menus!"
HOMEPAGE="http://dvd-slideshow.sourceforge.net/"
SRC_URI="mirror://sourceforge/dvd-slideshow/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-video/dvdauthor-0.6.11
	virtual/cdrtools
	app-shells/bash
	media-libs/netpbm
	>=media-gfx/imagemagick-5.5.4
	media-video/mjpegtools
	media-video/transcode
	media-fonts/urw-fonts
	>=media-video/ffmpeg-0.4.8
	media-sound/vorbis-tools
	media-sound/lame
	media-sound/sox
	media-sound/toolame
	media-gfx/jhead"

RDEPEND="${DEPEND}
	sys-devel/bc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bugfix taken from QDVDAuthor
	epatch "${FILESDIR}/${P}.patch" || die "epatch failed"
}

src_install() {
	dobin *2slideshow dvd-{encode,menu,slideshow}
	dodoc INSTALL* TODO* dvd-slideshowrc dvd-{burn,iso}
	dohtml doc/*.html
	doman man/*
}
