# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogmrip/ogmrip-0.13.0-r1.ebuild,v 1.1 2009/09/24 00:01:26 beandog Exp $

EAPI=2
inherit autotools eutils gnome2

DESCRIPTION="Graphical frontend and libraries for ripping DVDs and encoding to AVI/OGM/MKV/MP4"
HOMEPAGE="http://ogmrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogmrip/${P}.tar.gz
	mirror://gentoo/gnome-mplayer-0.9.6-gconf-2.m4.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="aac debug doc dts gtk hal libnotify matroska mp3 mp4 nls ogm spell srt theora vorbis x264 xvid"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND=">=dev-libs/glib-2.14
	>=app-i18n/enca-1
	>=media-libs/libdvdread-0.9.6
	>=media-video/mplayer-1.0_rc2[dvd,encode,xvid?,dts?,x264?]
	virtual/eject
	aac? ( >=media-libs/faac-1.26 )
	gtk? ( >=x11-libs/gtk+-2.12
		>=gnome-base/gconf-2.24
		>=gnome-base/libglade-2.6.3
		libnotify? ( >=x11-libs/libnotify-0.4.4 )
		media-video/mplayer[jpeg] )
	hal? ( >=sys-apps/hal-0.5.9 )
	matroska? ( >=media-video/mkvtoolnix-2.4 )
	mp3? ( >=media-sound/lame-3.98 )
	mp4? ( >=media-video/gpac-0.4.4 )
	ogm? ( >=media-sound/ogmtools-1.3 )
	spell? ( >=app-text/enchant-1.2 )
	srt? ( media-libs/libpng
		|| ( ( >=app-text/tesseract-2 media-libs/tiff )
		>=app-text/gocr-0.45 >=app-text/ocrad-0.15 ) )
	theora? ( >=media-libs/libtheora-1 )
	vorbis? ( >=media-sound/vorbis-tools-1.2 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		>=dev-util/intltool-0.35 )
	dev-util/gtk-doc-am
	>=dev-util/pkgconfig-0.12
	doc? ( >=dev-libs/libxslt-1.1.24 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog README TODO"

	G2CONF="${G2CONF}
		$(use_enable aac aac-support)
		$(use_enable debug maintainer-mode)
		$(use_enable gtk gtk-support)
		$(use_enable hal hal-support)
		$(use_enable libnotify libnotify-support)
		$(use_enable matroska mkv-support)
		$(use_enable mp3 mp3-support)
		$(use_enable mp4 mp4-support)
		$(use_enable ogm ogm-support)
		$(use_enable spell enchant-support)
		$(use_enable srt srt-support)
		$(use_enable theora theora-support)
		$(use_enable vorbis vorbis-support)
		$(use_enable x264 x264-support)
		$(use_enable xvid xvid-support)
		$(use_enable nls)
		--disable-gtk-doc"
}

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${P}-libdvdread.patch
	epatch "${FILESDIR}"/${P}-no-profile.patch
	AT_M4DIR=${WORKDIR} eautoreconf
}
