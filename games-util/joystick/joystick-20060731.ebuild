# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/joystick/joystick-20060731.ebuild,v 1.1 2006/07/31 04:51:35 vapier Exp $

inherit eutils

DESCRIPTION="joystick testing utilities"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~vojtech/input/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="sdl"

DEPEND="sdl? ( media-libs/libsdl )"

S=${WORKDIR}/utils

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/joystick-MCS-defines.patch
	epatch "${FILESDIR}"/joystick-jstest-segv.patch
}

src_compile() {
	local SDL
	use sdl && SDL=1 || SDL=0
	emake SDL=${SDL} || die
}

src_install() {
	dobin $(find . -type f -a -perm +1) || die "dobin"
	dodoc README
}
