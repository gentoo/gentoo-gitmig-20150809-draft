# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/joystick/joystick-20060731.ebuild,v 1.4 2009/01/29 08:24:46 mr_bones_ Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="joystick testing utilities"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~vojtech/input/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="sdl"

DEPEND="sdl? ( media-libs/libsdl )"

S=${WORKDIR}/utils

src_prepare() {
	epatch \
		"${FILESDIR}"/joystick-MCS-defines.patch \
		"${FILESDIR}"/joystick-jstest-segv.patch
	sed -i \
		-e '/^CC/d' \
		Makefile \
		|| die 'sed failed'
}

src_compile() {
	local SDL
	tc-export CC
	use sdl && SDL=1 || SDL=0
	emake SDL=${SDL} || die "emake failed"
	emake inputattach || die "inputattach failed"
}

src_install() {
	dobin $(find . -type f -a -perm +1) || die "dobin"
	dodoc README
}
