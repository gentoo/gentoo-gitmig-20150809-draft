# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/eplayer/eplayer-0.7.20040207.ebuild,v 1.1 2004/02/08 00:50:01 vapier Exp $

inherit enlightenment

DESCRIPTION="an audio player built on the EFL"

DEPEND="media-libs/libvorbis
	>=media-video/ffmpeg-0.4.8
	>=x11-libs/ecore-1.0.0.20031213_pre4
	>=x11-libs/evas-1.0.0.20031018_pre12
	>=media-libs/edje-0.0.1.20040201
	>=x11-libs/ewl-0.0.3.20031225
	>=x11-libs/esmart-0.0.2.20031018"

src_unpack() {
	enlightenment_src_unpack
	cd ${S}
	use fbcon || sed -i '/Ecore_Fb/s:.*::' src/eplayer.h
}
