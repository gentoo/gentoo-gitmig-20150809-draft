# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-2.5-r2.ebuild,v 1.3 2007/07/02 13:57:20 peper Exp $

DESCRIPTION="Sound libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64"
IUSE=""
RESTRICT="strip"

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-2.5.5-r2
	!<=app-emulation/emul-linux-x86-medialibs-1.1"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv emul/linux/x86/usr/lib usr/lib32 || die
	rmdir emul/linux/x86/usr emul/linux/x86 emul/linux emul || die
	sed -i 's:/emul/linux/x86::' usr/bin/artsdsp32 usr/bin/esddsp32 || die
}

src_install() {
	cp -a "${WORKDIR}"/* "${D}"/ || die
}
