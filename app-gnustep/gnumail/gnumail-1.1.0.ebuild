# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/gnumail/gnumail-1.1.0.ebuild,v 1.3 2004/02/07 02:13:12 agriffis Exp $

inherit gnustep

IUSE="${IUSE} xface crypt"
S=${WORKDIR}/GNUMail

newdepend dev-util/gnustep-gui
newdepend app-gnustep/pantomime

DESCRIPTION="A fully featured mail application for GNUstep"
HOMEPAGE="http://www.collaboration-world.com/gnumail/"
SRC_URI="http://www.collaboration-world.com/gnumail.data/releases/Stable/GNUMail-${PV}.tar.gz"

DEPEND="${DEPEND}"
RDEPEND="${RDEPEND} dev-util/gnustep-back"

KEYWORDS="x86 ~ppc ~alpha"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack GNUMail-${PV}.tar.gz
	cd ${S}
}

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
