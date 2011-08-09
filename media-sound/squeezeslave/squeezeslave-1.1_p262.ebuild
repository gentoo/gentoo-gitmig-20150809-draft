# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezeslave/squeezeslave-1.1_p262.ebuild,v 1.1 2011/08/09 08:01:28 radhermit Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A lightweight streaming audio player for squeezeboxserver"
HOMEPAGE="http://squeezeslave.googlecode.com"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac +alsa display wma"

RDEPEND="media-libs/libmad
	media-libs/flac
	media-libs/libvorbis
	media-libs/libogg
	media-libs/portaudio[alsa?]
	aac? ( virtual/ffmpeg )
	wma? ( virtual/ffmpeg )
	display? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	! use display && sed -i -e "/display/d" Makefile
	! use aac && sed -i -e "/AAC/d" Makefile
	! use wma && sed -i -e "/WMA/d" Makefile

	epatch "${FILESDIR}"/${P}-ffmpeg.patch

	tc-export CC AR
}

src_install() {
	dobin bin/${PN}
	dodoc ChangeLog TODO

	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
