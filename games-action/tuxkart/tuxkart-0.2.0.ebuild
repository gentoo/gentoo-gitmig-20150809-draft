# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/tuxkart/tuxkart-0.2.0.ebuild,v 1.3 2003/12/12 09:27:17 avenj Exp $

inherit games eutils

DESCRIPTION="A racing game starring Tux, the linux penguin"
SRC_URI="mirror://sourceforge/tuxkart/${P}.tar.gz"
HOMEPAGE="http://tuxkart.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha amd64"

DEPEND=">=media-libs/plib-1.6.0
	virtual/x11
	virtual/glut
	virtual/opengl"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/01tuxkart.patch

	# apparently <sys/perm.h> doesn't exist on alpha
	if use alpha; then
		epatch ${FILESDIR}/tuxkart-0.2.0-alpha.patch
	fi
}

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR_BASE} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	rm -rf ${D}/usr/share/tuxkart/

	dodoc AUTHORS  CHANGES  COPYING  LICENSE  NEWS  README
	dohtml doc/*.html

	prepgamesdirs
}
