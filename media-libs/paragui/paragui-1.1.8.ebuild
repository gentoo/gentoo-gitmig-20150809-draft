# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/paragui/paragui-1.1.8.ebuild,v 1.1 2004/11/22 02:45:13 vapier Exp $

DESCRIPTION="A cross-platform high-level application framework and GUI library"
HOMEPAGE="http://www.paragui.org/"
SRC_URI="http://freesoftware.fsf.org/download/paragui/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
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

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README* doc/{RELEASENOTES,TODO}
	newdoc TODO ROADMAP
}
