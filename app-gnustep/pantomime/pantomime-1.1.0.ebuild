# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/pantomime/pantomime-1.1.0.ebuild,v 1.3 2004/01/29 16:58:21 agriffis Exp $

IUSE="ssl"

inherit base gnustep

DESCRIPTION="A set of Objective-C classes that model a mail system"
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
LICENSE="LGPL-2.1"
SRC_URI="http://www.collaboration-world.com/pantomime.data/releases/Stable/${PN/p/P}-${PV}.tar.gz"
KEYWORDS="~x86 ~ppc ~alpha"
SLOT="0"
S=${WORKDIR}/${PN/p/P}

src_compile() {
	egnustepmake
	if [ "`use ssl`" ]; then
		cd ${S}/Bundles/SSL
		make
		cd ${S}
	fi
}

src_install() {
	egnustepinstall

	if [ "`use ssl`" ]; then
		mkdir -p ${D}usr/GNUstep/System/Library/Pantomime
		cd ${S}/Bundles/SSL
		tar cf - TCPSSLConnection.bundle | ( cd ${D}usr/GNUstep/System/Library/Pantomime; tar xf - )
	fi
}

