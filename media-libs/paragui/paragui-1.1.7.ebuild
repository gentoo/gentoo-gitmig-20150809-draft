# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/paragui/paragui-1.1.7.ebuild,v 1.8 2006/03/27 03:38:58 chriswhite Exp $

inherit eutils

DESCRIPTION="A cross-platform high-level application framework and GUI library"
HOMEPAGE="http://www.paragui.org/"
SRC_URI="http://freesoftware.fsf.org/download/paragui/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2
	=dev-libs/libsigc++-1.2*
	>=media-libs/freetype-2
	media-libs/libpng
	dev-games/physfs
	media-libs/jpeg
	dev-libs/expat
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.1.8-header.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README* doc/{RELEASENOTES,TODO}
	newdoc TODO ROADMAP
}
