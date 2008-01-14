# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mediastreamer/mediastreamer-2.1.0.ebuild,v 1.1 2008/01/14 14:02:33 vapier Exp $

EAPI="1"

inherit eutils

DESCRIPTION="library to make audio and video real-time streaming and processing"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/stable/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa arts gsm ipv6 portaudio +video"

DEPEND="alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	portaudio? ( media-libs/portaudio )
	gsm? ( media-sound/gsm )
	video? (
		media-video/ffmpeg
		media-libs/libsdl
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gsm.patch
	epatch "${FILESDIR}"/${P}-headers.patch
}

src_compile() {
	econf \
		--disable-strict \
		$(use_enable ipv6) \
		$(use_enable alsa) \
		$(use_enable arts artsc) \
		$(use_enable portaudio) \
		$(use_enable video) \
		$(use_enable gsm) \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
