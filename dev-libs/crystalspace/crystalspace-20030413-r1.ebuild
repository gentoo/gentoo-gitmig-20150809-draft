# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crystalspace/crystalspace-20030413-r1.ebuild,v 1.1 2003/04/27 20:51:37 vapier Exp $

inherit games

DESCRIPTION="portable 3D Game Development Kit written in C++"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="http://crystal.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"
IUSE="oggvorbis mikmod openal freetype 3ds mng"

DEPEND=">=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b
	mng? ( media-libs/libmng )
	mikmod? ( media-libs/libmikmod )
	3ds? ( media-libs/lib3ds )
	freetype? ( >=media-libs/freetype-2.0 )
	openal? ( media-libs/openal )
	zlib? ( sys-libs/zlib )
	oggvorbis? ( >=media-libs/libogg-1.0 )
		>=media-libs/libvorbis-1.0 )
	x86? ( dev-lang/nasm )
	dev-libs/ode
	>=dev-lang/perl-5.6.1
	!dev-libs/crystalspace-cvs"

S=${WORKDIR}/CS

CRYSTAL_PREFIX=${GAMES_PREFIX_OPT}/crystal

src_compile() {
	./configure --prefix=${CRYSTAL_PREFIX} || die
	make all || die
}

src_install() {
	dodir ${CRYSTAL_PREFIX}
	make INSTALL_DIR=${D}/${CRYSTAL_PREFIX} install || die

	insinto /etc/env.d
	echo "CRYSTAL=${CRYSTAL_PREFIX}" > ${T}/90crystalspace
	echo "CEL=${CRYSTAL_PREFIX}" >> ${T}/90crystalspace 
	doins ${T}/90crystalspace

	dodir ${GAMES_BINDIR}
	dosym ${CRYSTAL_PREFIX}/bin/cs-config ${GAMES_BINDIR}/cs-config

	prepgamesdirs
}
