# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/sdljoytest/sdljoytest-11102003.ebuild,v 1.1 2005/07/21 03:34:29 vapier Exp $

DESCRIPTION="SDL app to test joysticks and game controllers"
HOMEPAGE="http://sdljoytest.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdljoytest/SDLJoytest-GL-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	virtual/opengl
	media-libs/sdl-image"

S=${WORKDIR}/SDLJoytest-GL

src_unpack() {
	unpack ${A}
	cd "${S}"
	make clean || die "cleaning"
	sed -i \
		-e 's:/usr/local:/usr:' \
		joytest.h || die "seding data path"
}

src_compile() {
	emake \
		CFLAGS="$(sdl-config --cflags) ${CFLAGS}" \
		LDFLAGS="$(sdl-config --libs) -lGL ${LDFLAGS}" \
		|| die
}

src_install() {
	dobin SDLJoytest-GL || die "dobin"
	insinto /usr/share/SDLJoytest-GL
	doins *.bmp || die "data"
	doman SDLJoytest.1
	dodoc README
}
