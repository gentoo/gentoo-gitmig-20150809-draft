# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/paragui/paragui-1.0.3.ebuild,v 1.2 2003/01/15 00:23:10 vapier Exp $

DESCRIPTION="A cross-platform high-level application framework and GUI library"
SRC_URI="http://freesoftware.fsf.org/download/paragui/stable.pkg/1.0.3/${P}.tar.gz"
HOMEPAGE="http://www.paragui.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.1-r1
	dev-libs/expat"

src_compile() {
	econf --enable-internalphysfs || die "configure failure"
	emake || die "Compile failure"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README* RELEASENOTES.final TODO THANKS
}
