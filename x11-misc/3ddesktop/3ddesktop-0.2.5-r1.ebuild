# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/3ddesktop/3ddesktop-0.2.5-r1.ebuild,v 1.2 2004/04/13 15:56:40 kugelfang Exp $

DESCRIPTION="OpenGL virtual desktop switching"
HOMEPAGE="http://desk3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/desk3d/${P}.tar.gz
	mirror://gentoo/3ddesk-memusage-fix.patch.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/x11
		media-libs/imlib2
		x11-base/opengl-update"

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/3ddesk-memusage-fix.patch.bz2
}

src_compile() {
	econf || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc README AUTHORS COPYING TODO ChangeLog README.windowmanagers

}
