# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/avp-cvs/avp-cvs-20031110.ebuild,v 1.5 2004/02/20 06:40:07 mr_bones_ Exp $

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

S=${WORKDIR}/${ECVS_MODULE}

pkg_setup() {
	if has_version 'media-video/nvidia-glx' &&	has_version '<media-video/nvidia-glx-1.0.5328' ; then
		ewarn "Your version of opengl may not allow this package to compile."
		ewarn "You need either the xfree opengl or nvidia-glx at least version 1.0.5328."
	fi
}

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
