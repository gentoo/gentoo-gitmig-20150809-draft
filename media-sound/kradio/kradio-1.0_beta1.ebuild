# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kradio/kradio-1.0_beta1.ebuild,v 1.1 2005/05/24 09:46:16 phosphan Exp $

inherit kde

MY_PV="${PV/_/}"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="kradio is a radio tuner application for KDE"
HOMEPAGE="http://kradio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="lirc encode vorbis ogg"

DEPEND="lirc? ( app-misc/lirc )
	media-libs/libsndfile
	kde-base/unsermake
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )"
need-kde 3.2

src_compile() {
	if ! use vorbis; then
		sed -e 's/\(ac_cv_lib_vorbisenc_vorbis_encode_init=\)yes$/\1no/' \
			-i configure
	fi
	if ! use encode; then
		sed -e 's/\(ac_cv_lib_mp3lame_lame_init=\)yes$/\1no/' \
			-i configure
	fi
	if ! use ogg; then
		sed -e 's/\(ac_cv_lib_ogg_ogg_stream_packetin=\)yes$/\1no/' \
			-i configure
	fi
	export PATH="${PATH}:/usr/kde/unsermake/"
	econf $(use_with arts) || die "configure failed"
	unsermake ${MAKEOPTS} || die "unsermake failed"
}

src_install() {
	export PATH="${PATH}:/usr/kde/unsermake"
	unsermake DESTDIR="${D}" install || die "unsermake install failed"
}

src_test() {
	export PATH="${PATH}:/usr/kde/unsermake"
	unsermake check
}
