# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.3.ebuild,v 1.7 2005/01/28 19:26:56 luckyduck Exp $

IUSE="gtk"

DESCRIPTION="Screen capture utility enabling you to create videos of your desktop for illustration or documentation purposes."
HOMEPAGE="http://xvidcap.sourceforge.net/"
SRC_URI="mirror://sourceforge/xvidcap/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
RDEPEND="gtk? ( >=x11-libs/gtk+-2.0.0 )
	>=media-video/ffmpeg-0.4.7
	<media-video/ffmpeg-0.4.9_pre1
	media-libs/libpng
	media-libs/jpeg
	sys-libs/zlib
	virtual/x11"

SLOT="0"

src_compile() {
	use gtk && myconf="${myconf} --with-gtk2"

	econf ${myconf} || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	# Fix for #58322
	rm -fr ${D}/usr/share/doc/${PN}_${PV}
	dodoc NEWS TODO README AUTHORS INSTALL ChangeLog XVidcap.ad
}
