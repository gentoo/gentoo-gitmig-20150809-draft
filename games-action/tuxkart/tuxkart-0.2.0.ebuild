# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/tuxkart/tuxkart-0.2.0.ebuild,v 1.4 2003/12/15 04:53:16 mr_bones_ Exp $

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
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install         || die "make install failed"
	dodoc AUTHORS CHANGES NEWS README || die "dodoc failed"
	dohtml doc/*.html                 || die "dohtml failed"
	rm -rf ${D}/usr/share/tuxkart/

	prepgamesdirs
}
