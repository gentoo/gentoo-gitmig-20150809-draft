# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/paragui/paragui-1.1.7.ebuild,v 1.3 2004/07/23 22:45:02 mr_bones_ Exp $

DESCRIPTION="A cross-platform high-level application framework and GUI library"
HOMEPAGE="http://www.paragui.org/"
SRC_URI="http://freesoftware.fsf.org/download/paragui/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.1-r1
	>=dev-libs/libsigc++-1.2.5
	dev-libs/expat
	dev-games/physfs"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README* RELEASENOTES.final TODO THANKS
}
