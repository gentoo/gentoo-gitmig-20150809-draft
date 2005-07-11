# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/3ddesktop/3ddesktop-0.2.8.ebuild,v 1.4 2005/07/11 22:53:55 swegener Exp $

DESCRIPTION="OpenGL virtual desktop switching"
HOMEPAGE="http://desk3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/desk3d/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/x11
	media-libs/imlib2
	x11-base/opengl-update"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README AUTHORS TODO ChangeLog README.windowmanagers
}
