# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/avp-cvs/avp-cvs-20030314.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

ECVS_PASS="anonymous"
ECVS_SERVER="icculus.org:/cvs/cvsroot"
ECVS_MODULE="avp"
inherit cvs games

DESCRIPTION="Linux port of Aliens vs Predator"
HOMEPAGE="http://www.icculus.org/avp/"

LICENSE="AvP"
SLOT="0"
KEYWORDS="x86"

DEPEND="x11-base/xfree
	media-libs/openal
	media-libs/libsdl
	>=sys-apps/sed-4"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	sed -i \
		-e "/^CFLAGS =/s:=.*:=${CFLAGS}:" Makefile || \
			die "sed Makefile failed"
	make || die "make failed"
}

src_install() {
	dogamesbin AvP
	dodoc README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "please follow the instructions in"
	einfo "/usr/share/doc/${PF}/README.gz"
	einfo "to install the rest of the game"
}
