# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-metamod/halflife-metamod-1.17.2.ebuild,v 1.1 2004/08/31 22:13:42 vapier Exp $

inherit games gcc

DESCRIPTION="plugin manager for Half-Life server"
HOMEPAGE="http://www.metamod.org/"
SRC_URI="x86? ( mirror://sourceforge/metamod/metamod-${PV}-linux.tar.gz )"
#	amd64? ( mirror://sourceforge/metamod/metamod-${PV}-linux-amd64.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86" # amd64
IUSE=""

#DEPEND="src? ( dev-games/hlsdk )
#	>=sys-apps/sed-4"
RDEPEND="|| ( games-server/halflife-server games-server/halflife-steam )"

S="${WORKDIR}"

#src_unpack() {
#	unpack ${A}
#	use src && [ `gcc-major-version` -eq 3 ] \
#		&& sed -i 's:-malign:-falign:g' `find -name Makefile`
#}

#src_compile() {
#	use src || return 0
#	make \
#		SDKTOP=${GAMES_LIBDIR}/hlsdk \
#		CCO="${CFLAGS}" \
#		CC="$(gcc-getCC)" \
#		opt \
#		|| die
#}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife/addons/metamod
	dodir ${dir}

#	if use src ; then
#		make \
#			SDKTOP=${GAMES_LIBDIR}/hlsdk \
#			INST_DIR=${D}/${dir} \
#			OPT=opt \
#			install \
#			|| die
#	else
		exeinto ${dir}/dlls
		doexe *.so
#	fi
#	insinto ${dir}
#	doins doc/*.ini

#	insinto /usr/include/metamod
#	doins metamod/*.h

#	dodoc doc/* doc/txt/*
#	dohtml -r doc/html/*

	prepgamesdirs
}
