# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogmrip/ogmrip-0.11.2-r1.ebuild,v 1.2 2008/04/28 20:12:45 drac Exp $

inherit gnome2 eutils

DESCRIPTION="Graphical frontend and libraries for ripping DVDs and encoding to AVI/OGM/MKV/MP4"
HOMEPAGE="http://ogmrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogmrip/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="aac debug doc dts gtk hal jpeg libnotify matroska spell srt theora x264"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND=">=dev-libs/glib-2.6
	>=app-i18n/enca-1.0
	>=media-libs/libdvdread-0.9.7
	virtual/eject
	>=media-video/mplayer-1.0_pre4
	>=media-sound/ogmtools-1.4
	>=media-sound/vorbis-tools-1.0
	>=media-sound/lame-3.96
	aac? ( >=media-libs/faac-1.24 )
	gtk? ( >=x11-libs/gtk+-2.6
		>=gnome-base/gconf-2.6
		>=gnome-base/libglade-2.5
		libnotify? ( >=x11-libs/gtk+-2.10
			>=x11-libs/libnotify-0.4.3 ) )
	hal? ( >=sys-apps/hal-0.4.2 )
	spell? ( >=app-text/enchant-1.1 )
	matroska? ( >=media-video/mkvtoolnix-1.8.1 )
	theora? ( >=media-libs/libtheora-1.0_alpha6 )
	srt? ( || ( >=app-text/gocr-0.39 >=app-text/ocrad-0.15 ) )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1.4-r1
		>=dev-libs/libxslt-1.1.20-r1 )"

DOCS="AUTHORS ChangeLog README NEWS TODO"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable doc gtk-doc)
		$(use_enable aac aac-support)
		$(use_enable debug maintainer-mode)
		$(use_enable gtk gtk-support)
		$(use_enable hal hal-support)
		$(use_enable libnotify libnotify-support)
		$(use_enable matroska matroska-support)
		$(use_enable spell enchant-support)
		$(use_enable srt srt-support)
		$(use_enable theora theora-support)"

	if ! built_with_use -a media-video/mplayer dvd encode xvid; then
		eerror "Please check that your USE flags contain 'dvd', 'encode', 'xvid'"
		eerror "and emerge mplayer again."
		die "MPlayer is missing required USE flags (see above for details)."
	fi
	if use dts && ! built_with_use -a media-video/mplayer dts; then
		eerror "Please check that your USE flags contain 'dts'"
		eerror "and emerge mplayer again."
		die "MPlayer is missing required USE flags (see above for details)."
	fi
	if use x264 && ! built_with_use -a media-video/mplayer x264; then
		eerror "Please check that your USE flags contain 'x264'"
		eerror "and emerge mplayer again."
		die "MPlayer is missing required USE flags (see above for details)."
	fi
	if use jpeg && ! built_with_use -a media-video/mplayer jpeg; then
		eerror "Please check that your USE flags contain 'jpeg'"
		eerror "and emerge mplayer again."
		die "MPlayer is missing required USE flags (see above for details)."
	fi
}
