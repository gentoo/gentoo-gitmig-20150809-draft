# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-metamod/halflife-metamod-1.16.2.ebuild,v 1.3 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games gcc

DESCRIPTION="plugin manager for Half-Life server"
HOMEPAGE="http://www.metamod.org/"
SRC_URI="http://www.metamod.org/files/metamod-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="src"

DEPEND="src? ( dev-games/hlsdk )
	>=sys-apps/sed-4"
RDEPEND="games-server/halflife-server"

S=${WORKDIR}/metamod-${PV}

src_unpack() {
	unpack ${A}
	[ `use src` ] && [ `gcc-major-version` -eq 3 ] \
		&& sed -i 's:-malign:-falign:g' `find -name Makefile`
}

src_compile() {
	[ `use src` ] || return 0
	make \
		SDKTOP=${GAMES_LIBDIR}/hlsdk \
		CCO="${CFLAGS}" \
		CC="$(gcc-getCC)" \
		opt \
		|| die
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife/addons/metamod
	dodir ${dir}

	if [ `use src` ] ; then
		make \
			SDKTOP=${GAMES_LIBDIR}/hlsdk \
			INST_DIR=${D}/${dir} \
			OPT=opt \
			install \
			|| die
	else
		insinto ${dir}
		doins dlls/*.so
	fi
	insinto ${dir}
	doins doc/metamod.ini

	insinto /usr/include/metamod
	doins metamod/*.h

	dodoc doc/* doc/txt/*
	dohtml -r doc/html/*

	prepgamesdirs
}
