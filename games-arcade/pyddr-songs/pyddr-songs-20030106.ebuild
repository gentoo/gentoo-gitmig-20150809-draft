# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pyddr-songs/pyddr-songs-20030106.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

MY_PN=6jan
S=${WORKDIR}
DESCRIPTION="Music for the pyDDR game"
HOMEPAGE="http://icculus.org/pyddr/"
SRC_URI="http://clickass.org/~tgz/pyddr/${MY_PN}.ogg
	http://clickass.org/~tgz/pyddr/${MY_PN}.step"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86"
IUSE="X gnome"

DEPEND="virtual/glibc"

src_compile() {
	einfo "Nothing to compile, just music to copy"
}

src_install() {
	insinto /usr/share/pyddr/songs
	doins ${DISTDIR}/${MY_PN}.{ogg,step}
}
