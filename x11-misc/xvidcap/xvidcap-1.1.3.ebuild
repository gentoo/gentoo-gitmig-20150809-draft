# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.3.ebuild,v 1.1 2004/03/06 10:17:34 pyrania Exp $

inherit eutils

IUSE="gtk"

DESCRIPTION="Screen capture utility enabling you to create videos of your desktop for illustration or documentation purposes."
HOMEPAGE="http://xvidcap.sourceforge.net/"
SRC_URI="mirror://sourceforge/xvidcap/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
RDEPEND="gtk? ( >=x11-libs/gtk+-2.0.0 )
	>=media-video/ffmpeg-0.4.7
	media-libs/libpng
	media-libs/jpeg
	sys-libs/zlib
	virtual/x11"

SLOT="0"

src_compile() {
	use gtk && myconf="${myconf} --with-gtk2"

	econf ${myconf}
	emake
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	prepall
}
