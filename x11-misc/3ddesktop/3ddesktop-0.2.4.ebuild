# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/3ddesktop/3ddesktop-0.2.4.ebuild,v 1.9 2003/10/12 09:42:38 lanius Exp $

S=${WORKDIR}/${P}
DESCRIPTION="OpenGL virtual desktop switching"
HOMEPAGE="http://desk3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/desk3d/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=x11-base/xfree-4.2.0
	=media-libs/freetype-1*
	media-libs/imlib2"

src_compile() {
	econf || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc README AUTHORS COPYING TODO ChangeLog README.windowmanagers

}
