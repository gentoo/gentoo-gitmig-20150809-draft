# Copyriht 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/paragui/paragui-1.0.2.ebuild,v 1.4 2002/08/14 13:08:10 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A cross-platform high-level application framework and GUI library"
SRC_URI="http://freesoftware.fsf.org/download/paragui/${P}.tar.gz"
HOMEPAGE="http://www.paragui.org"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.1-r1
	dev-libs/expat"

src_compile() {
	econf || die "configure failure"
	emake || die "Compile failure"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README* RELEASENOTES.final TODO THANKS
}
