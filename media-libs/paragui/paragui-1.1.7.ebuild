# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/paragui/paragui-1.1.7.ebuild,v 1.1 2004/07/14 02:13:10 vapier Exp $

DESCRIPTION="A cross-platform high-level application framework and GUI library"
HOMEPAGE="http://www.paragui.org/"
SRC_URI="http://freesoftware.fsf.org/download/paragui/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.1-r1
	dev-libs/expat
	dev-games/physfs"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README* RELEASENOTES.final TODO THANKS
}
