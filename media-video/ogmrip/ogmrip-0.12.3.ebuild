# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogmrip/ogmrip-0.12.3.ebuild,v 1.1 2009/02/03 23:39:37 patrick Exp $

EAPI="2"

inherit gnome2 eutils

DESCRIPTION="Graphical frontend and libraries for ripping DVDs and encoding to AVI/OGM/MKV/MP4"
HOMEPAGE="http://ogmrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogmrip/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="aac debug doc dts gtk hal libnotify matroska mp3 mp4 ogm png spell srt theora vorbis x264 xvid"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND=">=dev-libs/glib-2.6
	>=app-i18n/enca-1.0
	>=media-libs/libdvdread-0.9.7
	>=media-video/mplayer-1.0_pre4[dvd,encode,xvid?,dts?,x264?]
	virtual/eject
	aac? ( >=media-libs/faac-1.24 )
	gtk? ( >=x11-libs/gtk+-2.6
		>=gnome-base/gconf-2.6
		>=gnome-base/libglade-2.5
		libnotify? ( >=x11-libs/gtk+-2.10
			>=x11-libs/libnotify-0.4.3 )
		media-video/mplayer[jpeg] )
	hal? ( >=sys-apps/hal-0.4.2 )
	matroska? ( >=media-video/mkvtoolnix-0.9 )
	mp3? ( >=media-sound/lame-3.96 )
	mp4? ( >=media-video/gpac-0.4.2 )
	ogm? ( >=media-sound/ogmtools-1.4 )
	png? ( media-libs/libpng )
	spell? ( >=app-text/enchant-1.1 )
	srt? ( || ( ( >=app-text/tesseract-2.00 media-libs/tiff )
		>=app-text/gocr-0.39
		>=app-text/ocrad-0.15 ) )
	theora? ( >=media-libs/libtheora-1.0_alpha6 )
	vorbis? ( >=media-sound/vorbis-tools-1.0 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1.4-r1
		 >=dev-libs/libxslt-1.1.20-r1 )"

DOCS="AUTHORS ChangeLog README NEWS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable aac aac-support)
		$(use_enable debug maintainer-mode)
		$(use_enable gtk gtk-support)
		$(use_enable hal hal-support)
		$(use_enable libnotify libnotify-support)
		$(use_enable matroska mkv-support)
		$(use_enable mp3 mp3-support)
		$(use_enable ogm ogm-support)
		$(use_enable spell enchant-support)
		$(use_enable srt srt-support)
		$(use_enable theora theora-support)
		$(use_enable vorbis vorbis-support)
		$(use_enable x264 x264-support)
		$(use_enable xvid xvid-support)"
}

src_configure() {
	gnome2_src_configure
}

src_compile(){
	emake || die "emake failed"
}
