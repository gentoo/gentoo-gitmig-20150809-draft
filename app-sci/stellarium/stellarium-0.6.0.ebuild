# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/stellarium/stellarium-0.6.0.ebuild,v 1.1 2004/07/28 23:42:26 ribosome Exp $

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://stellarium.free.fr/"
SRC_URI="http://stellarium.free.fr/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
