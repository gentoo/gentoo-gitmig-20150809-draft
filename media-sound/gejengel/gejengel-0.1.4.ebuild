# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gejengel/gejengel-0.1.4.ebuild,v 1.2 2010/08/30 01:58:26 phajdan.jr Exp $

EAPI=2
inherit base eutils multilib

DESCRIPTION="Lightweight audio player"
HOMEPAGE="http://code.google.com/p/gejengel"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="+alsa audioscrobbler debug dbus +ffmpeg flac libnotify mad openal pulseaudio syslog"

RDEPEND=">=dev-cpp/gtkmm-2.16
	>=dev-cpp/pangomm-2.24
	dev-cpp/libsexymm
	media-libs/taglib
	dev-db/sqlite
	|| ( media-gfx/imagemagick[cxx]
	media-gfx/graphicsmagick[imagemagick] )
	mad? ( media-libs/libmad )
	flac? ( media-libs/flac[cxx] )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20070330 )
	audioscrobbler? ( >=media-libs/lastfmlib-0.4 )
	dbus? ( dev-libs/dbus-glib )
	libnotify? ( x11-libs/libnotify )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	dev-libs/libxdg-basedir
	>=sys-devel/automake-1.11"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-shared \
		$(use_enable syslog logging) \
		$(use_enable debug) \
		$(use_enable openal) \
		$(use_enable audioscrobbler lastfm) \
		$(use_enable dbus) \
		$(use_enable libnotify) \
		$(use_enable mad) \
		$(use_enable flac) \
		$(use_enable ffmpeg) \
		$(use_enable alsa) \
		$(use_enable pulseaudio) \
		--disable-unittests
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
	rm -f "${D}"/usr/$(get_libdir)/libgejengel.{a,la}
}
