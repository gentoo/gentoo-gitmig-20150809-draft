# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmmp/qmmp-9999.ebuild,v 1.7 2010/07/14 15:38:44 hwoarang Exp $

EAPI="2"

inherit cmake-utils
[ "$PV" == "9999" ] && inherit subversion

DESCRIPTION="Qt4-based audio player with winamp/xmms skins support"
HOMEPAGE="http://qmmp.ylsoftware.com/index_en.php"
if [ "$PV" != "9999" ]; then
	SRC_URI="http://qmmp.ylsoftware.com/files/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI=""
	ESVN_REPO_URI="http://qmmp.googlecode.com/svn/trunk/qmmp/"
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"
# KEYWORDS further up
IUSE="aac +alsa +dbus bs2b cdda cover enca ffmpeg flac hal jack kde ladspa
libsamplerate lyrics +mad mms modplug mplayer mpris musepack notifier oss projectm pulseaudio scrobbler sndfile tray +vorbis wavpack"

RDEPEND="x11-libs/qt-gui:4[qt3support]
	media-libs/taglib
	alsa? ( media-libs/alsa-lib )
	bs2b? ( media-libs/libbs2b )
	cdda? ( dev-libs/libcdio )
	dbus? ( sys-apps/dbus )
	aac? ( media-libs/faad2 )
	enca? ( app-i18n/enca )
	flac? ( media-libs/flac )
	hal? ( sys-apps/hal )
	ladspa? ( media-libs/ladspa-cmt )
	libsamplerate? ( media-libs/libsamplerate )
	mad? ( media-libs/libmad )
	mms? ( media-libs/libmms )
	mplayer? ( media-video/mplayer )
	musepack? ( >=media-sound/musepack-tools-444 )
	modplug? ( >=media-libs/libmodplug-0.8.4 )
	vorbis? ( media-libs/libvorbis
		media-libs/libogg )
	jack? ( media-sound/jack-audio-connection-kit
		media-libs/libsamplerate )
	ffmpeg? ( media-video/ffmpeg )
	projectm? ( media-libs/libprojectm )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.9 )
	wavpack? ( media-sound/wavpack )
	scrobbler? ( net-misc/curl )
	sndfile? ( media-libs/libsndfile )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog README"

CMAKE_IN_SOURCE_BUILD="1"

qmmp_use_enable() {
	$(cmake-utils_use ${1} USE_${2})
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(qmmp_use_enable alsa ALSA)
		$(qmmp_use_enable aac AAC)
		$(qmmp_use_enable bs2b BS2B)
		$(qmmp_use_enable cover COVER)
		$(qmmp_use_enable cdda CDA)
		$(qmmp_use_enable dbus DBUS)
		$(qmmp_use_enable enca ENCA)
		$(qmmp_use_enable ffmpeg FFMPEG)
		$(qmmp_use_enable flac FLAC)
		$(qmmp_use_enable hal HAL)
		$(qmmp_use_enable jack JACK)
		$(qmmp_use_enable kde KDENOTIFY)
		$(qmmp_use_enable ladspa LADSPA)
		$(qmmp_use_enable lyrics LYRICS)
		$(qmmp_use_enable mad MAD)
		$(qmmp_use_enable mplayer MPLAYER)
		$(qmmp_use_enable mms MMS)
		$(qmmp_use_enable modplug MODPLUG)
		$(qmmp_use_enable mpris MPRIS)
		$(qmmp_use_enable musepack MPC)
		$(qmmp_use_enable notifier NOTIFIER)
		$(qmmp_use_enable oss OSS)
		$(qmmp_use_enable projectm PROJECTM)
		$(qmmp_use_enable pulseaudio PULSE)
		$(qmmp_use_enable scrobbler SCROBBLER)
		$(qmmp_use_enable sndfile SNDFILE)
		$(qmmp_use_enable tray STATICON)
		$(qmmp_use_enable libsamplerate SRC)
		$(qmmp_use_enable vorbis VORBIS)
		$(qmmp_use_enable wavpack WAVPACK)"

	cmake-utils_src_configure
}
