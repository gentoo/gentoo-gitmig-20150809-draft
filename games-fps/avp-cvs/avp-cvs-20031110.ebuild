# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/avp-cvs/avp-cvs-20031110.ebuild,v 1.2 2003/12/30 03:50:52 mr_bones_ Exp $

#ECVS_SERVER="icculus.org:/cvs/cvsroot"
ECVS_PASS="anonymous"
ECVS_MODULE="avp"
inherit cvs games

S="${WORKDIR}/${ECVS_MODULE}"
DESCRIPTION="Linux port of Aliens vs Predator"
HOMEPAGE="http://www.icculus.org/avp/"
SRC_URI="mirror://gentoo/avp-${PV}.tar.bz2"

KEYWORDS="x86"
LICENSE="AvP"
SLOT="0"
IUSE=""

DEPEND="x11-base/xfree
	media-libs/openal
	media-libs/libsdl
	>=sys-apps/sed-4"

src_unpack() {
	if [ -z "${ECVS_SERVER}" ] ; then
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
