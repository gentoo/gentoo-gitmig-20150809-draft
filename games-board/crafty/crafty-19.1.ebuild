# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/crafty/crafty-19.1.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

DESCRIPTION="chess engine"
SRC_URI="ftp://ftp.cis.uab.edu/pub/hyatt/v19/${P}.tar.gz"
HOMEPAGE="ftp://ftp.cis.uab.edu/pub/hyatt/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="icc"

DEPEND="virtual/glibc
	icc? ( >=dev-lang/icc-5.0 )"
RDEPEND="virtual/glibc"

S="${WORKDIR}"

src_compile() {
	local makeopts opt

	makeopts="${makeopts} CC=gcc CXX=g++ target=LINUX"

	mv Makefile Makefile.bak
	sed "/-o crafty/s/CC/CXX/" Makefile.bak > Makefile

	if use icc; then

		makeopts="${makeopts} CC=icc CXX=gcc"

		CFLAGS="-D_REENTRANT -O2 -fno-alias -tpp6"
		CFLAGS="${CFLAGS} -DCOMPACT_ATTACKS -DUSE_ATTACK_FUNCTIONS -DUSE_ASSEMBLY_A -DUSE_ASSEMBLY_B -DFAST -DSMP -DCPUS=4 -DCLONE -DDGT"

		CXFLAGS="-Wall -pipe -D_REENTRANT -march=i686 -O"
		CXFLAGS="${CXFLAGS} -Wall -fforce-mem -fomit-frame-pointer -fno-gcse -mpreferred-stack-boundary=2"

		makeopts="${makeopts} asm=X86-elf.o"

	else

		if test "${CHOST}" = "i686-pc-linux-gnu" -o "${CHOST}" = "i586-pc-linux-gnu";
		then

			# i586/i686 enhancements

			CFLAGS="${CFLAGS}"
			CFLAGS="${CFLAGS} -fforce-mem -fomit-frame-pointer -fno-gcse -mpreferred-stack-boundary=2"
			makeopts="${makeopts} asm=X86-elf.o"
			CFLAGS="${CFLAGS} -DCOMPACT_ATTACKS -DUSE_ATTACK_FUNCTIONS -DUSE_ASSEMBLY_A -DUSE_ASSEMBLY_B -DFAST -DSMP -DCPUS=4 -DCLONE -DDGT"

		else

			# fallback

			# let everything as is, is wont be optimized, but compile will hopefully work

			# not tested for ppc until now

			makeopts="${makeopts}"
		fi
	fi

	#added patch to close bug #5392 - Gerk
	[ ${ARCH} = "ppc" ] && patch -p0 < ${FILESDIR}/crafty-18.15-ppc.patch

	make ${makeopts} CXX=g++ crafty-make || die
}

src_install() {
	dobin crafty
}

pkg_postinstall() {
	einfo
	einfo "Note: No books or tablebases have been installed. If you want them, just"
	einfo "      download them from ${HOMEPAGE}."
	einfo "      You will find documentation there too. In most cases you take now "
	einfo "      your xboard compatible application, (xboard, eboard, knights) and "
	einfo "      just play chess against computer opponent. Have fun."
	einfo
}
