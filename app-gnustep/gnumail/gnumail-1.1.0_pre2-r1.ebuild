# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/gnumail/gnumail-1.1.0_pre2-r1.ebuild,v 1.1 2003/08/16 22:43:42 g2boojum Exp $

inherit gnustep

newdepend dev-util/gnustep-gui
newdepend app-gnustep/pantomime

S=${WORKDIR}/GNUMail
A=GNUMail-${PV/_/}.tar.gz

DESCRIPTION="A fully featured mail application for GNUstep"
HOMEPAGE="http://www.collaboration-world.com/gnumail/"
LICENSE="GPL-2"
DEPEND="${DEPEND}"
RDEPEND="${RDEPEND} dev-util/gnustep-back"
SRC_URI="http://www.collaboration-world.com/gnumail.data/releases/Stable/GNUMail-${PV/_/}.tar.gz"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE="${IUSE} xface crypt"

src_compile() {

	egnustepmake

	if [ "`use xface`" ]; then
		cd ${S}/Bundles/Face
		make
		cd ${S}
	fi

	if [ "`use crypt`" ]; then
		cd ${S}/Bundles/PGP
		make
		cd ${S}
	fi
}

src_install() {
	egnustepinstall

	use xface && cp -a ${S}/Bundles/Face/Face.bundle ${D}usr/GNUstep/System/Library/GNUMail/

	use crypt && cp -a ${S}/Bundles/PGP/PGP.bundle ${D}usr/GNUstep/System/Library/GNUMail/
}
