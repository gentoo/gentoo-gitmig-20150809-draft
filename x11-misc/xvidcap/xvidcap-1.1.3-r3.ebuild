# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.3-r3.ebuild,v 1.2 2006/02/16 19:54:03 nelchael Exp $

inherit eutils

IUSE="gtk"

DESCRIPTION="Screen capture utility enabling you to create videos of your desktop for illustration or documentation purposes."
HOMEPAGE="http://xvidcap.sourceforge.net/"
SRC_URI="mirror://sourceforge/xvidcap/${P}.tar.gz"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.0.0 )
	>=media-video/ffmpeg-0.4.9_pre1
	media-libs/libpng
	media-libs/jpeg
	sys-libs/zlib
	!gtk? (
		|| ( (
			x11-libs/libX11
			x11-libs/libXmu
			x11-libs/libXt
			x11-libs/libXext )
		virtual/x11 )
	)"

DEPEND="${RDEPEND}
	!gtk? (
		|| ( (
			x11-proto/xextproto
			x11-proto/xf86dgaproto
			x11-proto/videoproto
			x11-proto/xproto )
		virtual/x11 )
	)"

SLOT="0"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Fix bug #62741
	epatch "${FILESDIR}/${P}-use-ffmpeg-0.4.9.patch"

	# Fix bug #115675
	epatch "${FILESDIR}/${P}-new-ffmpeg.patch"

	# Fix bug #120551
	epatch "${FILESDIR}/${P}-alpha_mask.patch"
}

src_compile() {
	econf `use_with gtk gtk2` || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	# Fix for #58322
	rm -fr ${D}/usr/share/doc/${PN}_${PV}
	dodoc NEWS TODO README AUTHORS ChangeLog XVidcap.ad
}
