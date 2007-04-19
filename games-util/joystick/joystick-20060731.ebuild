# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/joystick/joystick-20060731.ebuild,v 1.3 2007/04/19 22:32:10 mr_bones_ Exp $

inherit eutils

DESCRIPTION="joystick testing utilities"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~vojtech/input/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="sdl"

DEPEND="sdl? ( media-libs/libsdl )"

S=${WORKDIR}/utils

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/joystick-MCS-defines.patch \
		"${FILESDIR}"/joystick-jstest-segv.patch
}

src_compile() {
	local SDL
	use sdl && SDL=1 || SDL=0
	emake SDL=${SDL} || die "emake failed"
	emake inputattach || die "inputattach failed"
}

src_install() {
	dobin $(find . -type f -a -perm +1) || die "dobin"
	dodoc README
}
