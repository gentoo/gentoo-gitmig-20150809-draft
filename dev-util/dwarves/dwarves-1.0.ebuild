# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dwarves/dwarves-1.0.ebuild,v 1.2 2007/12/30 18:26:57 flameeyes Exp $

inherit toolchain-funcs multilib cmake-utils

DESCRIPTION="pahole (Poke-a-Hole) and other DWARF2 utilities"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=summary"
SRC_URI="http://userweb.kernel.org/~acme/dwarves/${P}.tar.bz2"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="dev-libs/elfutils"

S=${WORKDIR}

src_compile() {
	tc-export CC CXX LD

	use debug || append-flags -DNDEBUG

	mycmakeargs="-D__LIB=$(get_libdir)"
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	dodoc README README.ctracer
}
