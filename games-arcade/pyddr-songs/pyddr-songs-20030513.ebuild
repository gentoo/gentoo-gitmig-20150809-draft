# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pyddr-songs/pyddr-songs-20030513.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

S=${WORKDIR}
DESCRIPTION="Music for the pyDDR game"
HOMEPAGE="http://icculus.org/pyddr/"
SRC_URI="http://icculus.org/pyddr/6jan.ogg
	http://icculus.org/pyddr/6jan.step

	http://icculus.org/pyddr/0forkbomb.ogg
	http://icculus.org/pyddr/0forkbomb.step

	http://icculus.org/pyddr/synrg.ogg
	http://icculus.org/pyddr/synrg.step
	http://icculus.org/pyddr/synrg-bg.png"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86"
IUSE=""

DEPEND=""

src_compile() {
	einfo "Nothing to compile, just music to copy"
}

src_install() {
	insinto /usr/share/games/pyddr/songs
	doins ${DISTDIR}/6jan.{ogg,step}
	doins ${DISTDIR}/0forkbomb.{ogg,step}
	doins ${DISTDIR}/synrg.{ogg,step} ${DISTDIR}synrg-bg.png

}
