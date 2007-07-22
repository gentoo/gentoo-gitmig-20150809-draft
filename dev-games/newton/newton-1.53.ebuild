# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/newton/newton-1.53.ebuild,v 1.2 2007/07/22 09:48:15 graaff Exp $

DESCRIPTION="an integrated solution for real time simulation of physics environments"
HOMEPAGE="http://www.physicsengine.com/"
SRC_URI="http://www.physicsengine.com/downloads/${PN}Linux-${PV}.tar.gz
	http://www.newtondynamics.com/downloads/${PN}Linux-${PV}.tar.gz"

LICENSE="newton"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="doc? (
	x11-libs/libXmu
	x11-libs/libXi
	virtual/opengl
	virtual/glut )"

DEPEND="${RDEPEND}"

S=${WORKDIR}/newtonSDK

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use doc; then
		cd samples
		rm -rf gl
		sed -i \
			-e "s:-I ../gl:-I /usr/include/GL:" \
			tutorial_05_UsingJoints/makefile \
			tutorial_09_SimpleVehicle/makefile \
			tutorial_04_IntroductionToMaterials/makefile \
			tutorial_10_CustomJoints/makefile \
			tutorial_01_GettingStarted/makefile \
			tutorial_02_UsingCallbacks/makefile \
			tutorial_08_HeightFieldCollision/makefile \
			tutorial_07_CharaterController/makefile \
			tutorial_06_UtilityFuntionality/makefile \
			tutorial_03_UsingCollisionTree/makefile \
			|| die "failed fixing sample makefiles"
		# This is commented out because this thing simply does not compile
		# with lots of other CFLAGS and I've been unable to determine exactly
		# what is causing it to fail, but even CFLAGS="-O2" fails.
#		sed -i \
#			-e "s:^FLAGS = -g -O0 -c -Wall:FLAGS = ${CFLAGS}:" \
#			makefile
	fi
}

src_compile() {
	if use doc; then
		cd samples
		emake || die "emake samples failed"
	fi
}

src_install() {
	dolib sdk/libNewton.a
	insinto /usr/include
	doins sdk/Newton.h

	if use doc; then
		find samples -name \*.elf | xargs rm
		find samples -name \*.o | xargs rm

		insinto /usr/share/${PN}
		doins -r `ls --ignore=bin samples/*`

		exeinto /usr/share/${PN}/bin
		dobin samples/bin/tutorial_*
	fi

	chmod -x doc/*
	dodoc doc/*

	prepgamesdirs
}
