# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cel/cel-20030413-r1.ebuild,v 1.1 2003/07/02 23:19:29 blauwers Exp $

inherit games

HOMEPAGE="http://cel.sourceforge.net/"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.gz"
DESCRIPTION="A game entity layer based on Crystal Space"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-libs/crystalspace
	dev-util/jam
	!dev-libs/cel-cvs"

S=${WORKDIR}/${PN}

CEL_PREFIX=${GAMES_PREFIX_OPT}/crystal

src_compile() {
	./autogen.sh || die
	PATH="${CEL_PREFIX}/bin:${PATH}" ./configure --prefix=${CEL_PREFIX} || die
	jam || die

	# Put the correct path there
	mv cel.cex cel.cex.DIST
	sed -e "s:/usr/local/cel:${CEL_PREFIX}:g" cel.cex.DIST > cel.cex
	# Make an environment config file
	echo "CEL=${CEL_PREFIX}" > 99cel-env
}

src_install() {
	into ${CEL_PREFIX}
	dolib.so *.so

	dobin cel.cex
	dobin celtst

	for inc in bl pf pl; do
		insinto ${CEL_PREFIX}/include/${inc}
		doins include/${inc}/*
	done

	insinto /etc/env.d
	doins 99cel-env

	prepgamesdirs
}
