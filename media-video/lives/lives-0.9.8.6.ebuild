# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lives/lives-0.9.8.6.ebuild,v 1.1 2007/08/26 09:15:18 lu_zero Exp $

inherit flag-o-matic

DESCRIPTION="Linux Video Editing System"

HOMEPAGE="http://lives.sf.net"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE="matroska ogg theora libvisual sox nls" #sdl jack dv"

DEPEND=">=media-video/mplayer-0.90-r2
		>=media-gfx/imagemagick-5.5.6
		>=dev-lang/perl-5.8.0-r12
		>=x11-libs/gtk+-2.2.1
		media-libs/libsdl
		>=media-video/ffmpeg-0.4.8
		>=media-libs/jpeg-6b-r3
		>=media-sound/sox-12.17.3-r3
		virtual/cdrtools
		theora? ( media-libs/libtheora )
		>=dev-lang/python-2.3.4
		matroska? ( media-video/mkvtoolnix
					media-libs/libmatroska )
		ogg? ( media-sound/ogmtools )
		>=media-video/mjpegtools-1.6.2
		libvisual? ( =media-libs/libvisual-0.2* )
		media-sound/jack-audio-connection-kit
		sox? ( media-sound/sox )
		sys-libs/libavc1394"

src_unpack() {
	unpack ${A}
	# hardcoding -03 is wrong!
	sed -i -e "s:-O3::g" \
	${S}/{,src,lives-plugins,lives-plugins/plugins/playback/video,lives-plugins/weed-plugins}/Makefile*
}

src_compile() {
	econf \
		$(use_enable libvisual) \
		$(use_enable nls) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	dodir /usr/share/pixmaps
	dodir /usr/share/applications
	make DESTDIR=${D} install || die
	dodoc AUTHORS FEATURES GETTING.STARTED
}
