# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/flatzebra/flatzebra-0.1.1.ebuild,v 1.13 2009/06/23 15:31:06 mr_bones_ Exp $

inherit autotools eutils

DESCRIPTION="A generic game engine for 2D double-buffering animation"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/en/"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-link-more-libs.patch" #bug #131839
	AT_M4DIR="${S}/macros" eautoreconf
}

src_install() {
	einstall \
		docdir="${D}/usr/share/doc/${PF}" \
		|| die
	rm -f "${D}/usr/share/doc/${PF}"/{COPYING,INSTALL}
	prepalldocs
}
