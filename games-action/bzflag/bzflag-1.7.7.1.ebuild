# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-1.7.7.1.ebuild,v 1.2 2004/01/26 11:05:50 mr_bones_ Exp $

inherit games

MY_P=${PN}-1.7g2
S=${WORKDIR}/${MY_P}
DESCRIPTION="OpenGL accelerated 3d tank combat simulator game"
SRC_URI="mirror://sourceforge/bzflag/${MY_P}.tgz"
HOMEPAGE="http://www.BZFlag.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/opengl"

src_compile() {
	egamesconf || die
	emake || die
}

src_install () {
	make install DESTDIR=${D} || die
	dodoc AUTHORS README.UNIX TODO README ChangeLog BUGS PORTING RELNOTES bzflag.lsm
	prepgamesdirs
}
