# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/flatzebra/flatzebra-0.1.1.ebuild,v 1.2 2004/09/13 07:22:18 mr_bones_ Exp $

DESCRIPTION="A generic game engine for 2D double-buffering animation"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/en/"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	einstall \
		docdir="${D}/usr/share/doc/${PF}" \
		|| die
	rm -f "${D}/usr/share/doc/${PF}"/{COPYING,INSTALL}
	prepalldocs
}
