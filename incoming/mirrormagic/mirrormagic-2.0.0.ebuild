# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp
# 23.Sept.2001 23.35 CET

A=mirrormagic-2.0.0.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Arcade style game for Unix / Linux."
SRC_URI="http://www.artsoft.org/RELEASES/unix/mirrormagic/${A}"
HOMEPAGE="http://www.artsoft.net/mirrormagic"

DEPEND=">=x11-base/xfree-4.0
	>=media-libs/sdl-image-1.1.0
	>=media-libs/sdl-mixer-1.1.0
	>=media-libs/sdl-net-1.1.0"

src_compile() {
    patch -p1 < ${FILESDIR}/mirrormagic.patch
    try make sdl
}

src_install () {
    exeinto /usr/games/${P}
    doexe mirrormagic
    insinto /usr/games/${P}/graphics
    doins graphics/*
    insinto /usr/games/${P}/levels/Classic_Games/
    doins levels/Classic_Games/*
    insinto /usr/games/${P}/levels/Classic_Games/classic_deflektor
    doins levels/Classic_Games/classic_deflektor/*
    insinto /usr/games/${P}/levels/Classic_Games/classic_mindbender
    doins levels/Classic_Games/classic_mindbender/*
    insinto /usr/games/${P}/music
    doins music/*
    insinto /usr/games/${P}/scores
    insinto /usr/games/${P}/sounds
    doins sounds/*
    dodoc README COPYING INSTALL CHANGES CREDITS
    dodir /usr/bin
    dosym /usr/games/${P}/mirrormagic /usr/bin/mirrormagic

}

