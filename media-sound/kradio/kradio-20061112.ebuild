# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kradio/kradio-20061112.ebuild,v 1.1 2008/02/13 10:41:11 phosphan Exp $

inherit eutils kde

MY_PV="snapshot-2006-11-12-r497"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="kradio is a radio tuner application for KDE"
HOMEPAGE="http://kradio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="lirc encode vorbis ogg"

DEPEND="lirc? ( app-misc/lirc )
	media-libs/libsndfile
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )
	arts? ( kde-base/arts )"

need-kde 3.5

UNSERMAKE="/usr/kde/unsermake"
set-kdedir

src_compile() {
	if ! use vorbis; then
		sed -e 's/\(ac_cv_lib_vorbisenc_vorbis_encode_init=\)yes$/\1no/' \
			-i configure || die "Couldn't disable vorbis support"
	fi
	if ! use encode; then
		sed -e 's/\(ac_cv_lib_mp3lame_lame_init=\)yes$/\1no/' \
			-i configure || die "Couldn't disable lame support"
	fi
	if ! use ogg; then
		sed -e 's/\(ac_cv_lib_ogg_ogg_stream_packetin=\)yes$/\1no/' \
			-i configure || die "Couldn't disable ogg support"
	fi
	if ! use lirc; then
		sed -e 's/lirc//' -i kradio3/plugins/Makefile.in
	fi

	kde_src_compile || die "make failed"
}
