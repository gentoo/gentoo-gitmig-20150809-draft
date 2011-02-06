# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dwarves/dwarves-9999.ebuild,v 1.5 2011/02/06 15:42:01 flameeyes Exp $

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/acme/pahole.git"

inherit toolchain-funcs multilib cmake-utils git flag-o-matic

DESCRIPTION="pahole (Poke-a-Hole) and other DWARF2 utilities"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=summary"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND=">=dev-libs/elfutils-0.131
	sys-libs/zlib"
DEPEND="${RDEPEND}"

src_compile() {
	tc-export CC CXX LD

	use debug || append-flags -DNDEBUG

	mycmakeargs="-D__LIB=$(get_libdir)"
	cmake-utils_src_compile
}

src_test() { :; }

src_install() {
	cmake-utils_src_install

	dodoc README README.ctracer || die
}
