# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gui/sdl-gui-0.10.3.ebuild,v 1.6 2009/09/11 16:36:24 vostorga Exp $

inherit eutils toolchain-funcs

MY_P="SDL_gui-${PV}"
DESCRIPTION="Graphical User Interface library that utilizes SDL"
HOMEPAGE="http://rhk.dataslab.com/SDL_gui"
SRC_URI="http://rhk.dataslab.com/SDL_gui/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.4
	>=media-libs/sdl-image-1.0.9
	>=media-libs/sdl-ttf-1.2.1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	sed -i -e s/-Werror// configure
}

src_compile() {
	RANLIB="$(tc-getRANLIB)" CXX="$(tc-getCXX)" CC="$(tc-getCC)" \
	LD="$(tc-getLD)" AR="$(tc-getAR)" \
		econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO
}
