# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/stella/stella-1.4.ebuild,v 1.1 2004/07/20 06:32:49 mr_bones_ Exp $

inherit games

DESCRIPTION="Stella Atari 2600 VCS Emulator"
HOMEPAGE="http://stella.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
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
