# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/stella/stella-1.4.1.ebuild,v 1.3 2005/02/24 02:23:20 mr_bones_ Exp $

inherit games

DESCRIPTION="Stella Atari 2600 VCS Emulator"
HOMEPAGE="http://stella.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="opengl"

DEPEND="virtual/libc
	media-libs/libsdl
	media-libs/libpng
	opengl? ( virtual/opengl )"

src_compile() {
	local target="linux"

	use opengl && target="linux-gl"
	cd ${S}/src/build
	emake OPTIMIZATIONS="${CFLAGS}" SMP="${MAKEOPTS}" ${target} \
		|| die "emake failed"
}

src_install() {
	dogamesbin src/build/stella || die "dogamesbin failed"

	insinto /etc
	doins src/emucore/stella.pro || die "doins failed"

	dohtml -r docs/
	rm -f License.txt
	dodoc *.txt
	prepgamesdirs
}
