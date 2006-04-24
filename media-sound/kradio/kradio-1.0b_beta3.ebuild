# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kradio/kradio-1.0b_beta3.ebuild,v 1.3 2006/04/24 14:55:14 phosphan Exp $

inherit eutils kde

MY_PV="1.0beta3b"
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
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )
	arts? ( kde-base/arts )"

RDEPEND="${DEPEND}"

need-kde 3.2

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-includehints.patch
}

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
	econf $(use_with arts) || die "configure failed"
	emake || die "emake failed"
}

