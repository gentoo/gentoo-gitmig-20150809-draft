# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dwarves/dwarves-1.8.ebuild,v 1.2 2010/09/10 05:14:56 ssuominen Exp $

inherit toolchain-funcs multilib cmake-utils flag-o-matic

DESCRIPTION="pahole (Poke-a-Hole) and other DWARF2 utilities"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=summary"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=dev-libs/elfutils-0.131
	sys-libs/zlib"
DEPEND="${RDEPEND}"

if [[ ${PV//_p} == ${PV} ]]; then
	SRC_URI="http://fedorapeople.org/~acme/dwarves/${P}.tar.bz2"
	S=${WORKDIR}
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
fi

PATCHES=( "${FILESDIR}"/${P}-glibc-212.patch )

src_compile() {
	tc-export CC CXX LD

	use debug || append-flags -DNDEBUG

	mycmakeargs="-D__LIB=$(get_libdir)"
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	dodoc README README.ctracer || die
}
