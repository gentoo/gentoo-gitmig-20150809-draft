# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/freerdp/freerdp-9999.ebuild,v 1.5 2011/09/04 16:34:45 floppym Exp $

EAPI="4"

inherit autotools-utils git-2

EGIT_REPO_URI="git://github.com/FreeRDP/FreeRDP-old.git"

DESCRIPTION="A Remote Desktop Protocol Client, forked from rdesktop"
HOMEPAGE="http://www.freerdp.com/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa cups debug-assert debug-gdi debug-kbd debug-nla
	debug-proto debug-serial debug-smartcard debug-sound
	debug-stream-assert directfb ffmpeg gnutls iconv ipv6 nss polarssl
	pulseaudio smartcard static-libs X xv"

DEPEND="alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	directfb? ( dev-libs/DirectFB )
	ffmpeg? ( virtual/ffmpeg )
	iconv? ( virtual/libiconv )
	pulseaudio? ( media-sound/pulseaudio )
	smartcard? ( sys-apps/pcsc-lite )
	gnutls? ( >=net-libs/gnutls-2.10.1 )
	!gnutls? (
		nss? ( dev-libs/nss )
		!nss? (
			polarssl? ( >=net-libs/polarssl-0.14.0 )
			!polarssl? ( >=dev-libs/openssl-0.9.8a )
		)
	)
	X? ( x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libxkbfile )
	xv? ( x11-libs/libXext
		x11-libs/libXv )"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

pkg_setup() {
	crypto=(
		$(usev gnutls)
		$(usev nss)
		$(usev polarssl)
		openssl
	)
	[[ ${#crypto[@]} > 1 ]] && \
		ewarn "${crypto[0]} crypto backend selected; this will disable tls support"
}

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable iconv)
		$(use_enable ipv6)
		--enable-largefile
		$(use_with alsa)
		--with-crypto=${crypto[0]}
		$(use_with cups printer cups)
		$(use_with debug-assert)
		$(use_with debug-gdi)
		$(use_with debug-kbd)
		$(use_with debug-nla)
		$(use_with debug-proto debug)
		$(use_with debug-serial)
		$(use_with debug-smartcard)
		$(use_with debug-sound)
		$(use_with debug-stream-assert)
		$(use_with directfb dfb)
		$(use_with ffmpeg)
		$(use_with pulseaudio pulse)
		$(use_with smartcard)
		$(use_with X x)
		$(use_with X xkbfile)
		$(use_with xv xvideo)
	)
	autotools-utils_src_configure
}
