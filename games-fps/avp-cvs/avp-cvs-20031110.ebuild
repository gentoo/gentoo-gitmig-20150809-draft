# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/avp-cvs/avp-cvs-20031110.ebuild,v 1.3 2004/01/03 18:10:13 vapier Exp $

#ECVS_SERVER="icculus.org:/cvs/cvsroot"
ECVS_PASS="anonymous"
ECVS_MODULE="avp"
inherit cvs games

DESCRIPTION="Linux port of Aliens vs Predator"
HOMEPAGE="http://www.icculus.org/avp/"
SRC_URI="mirror://gentoo/avp-${PV}.tar.bz2"

LICENSE="AvP"
SLOT="0"
KEYWORDS="x86"

DEPEND="x11-base/xfree
	media-libs/openal
	media-libs/libsdl
	>=sys-apps/sed-4"

S="${WORKDIR}/${ECVS_MODULE}"

src_unpack() {
	if [ "${ECVS_SERVER}" == "offline" ] ; then
		unpack ${A}
	else
		cvs_src_unpack
	fi

	cd ${S}

	sed -i \
		-e "/^CFLAGS =/s:=.*:=${CFLAGS}:" Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	make || die "make failed"
}

src_install() {
	dogamesbin AvP    || die "dogamesbin failed"
	dodoc README TODO || die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "please follow the instructions in"
	einfo "/usr/share/doc/${PF}/README.gz"
	einfo "to install the rest of the game"
}
