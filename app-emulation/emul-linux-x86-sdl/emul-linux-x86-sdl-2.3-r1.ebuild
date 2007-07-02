# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-2.3-r1.ebuild,v 1.3 2007/07/02 13:56:30 peper Exp $

DESCRIPTION="32bit SDL emulation for amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~herbs/emul/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64"
IUSE=""
RESTRICT="strip"

DEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-soundlibs-2.5-r1
	>=app-emulation/emul-linux-x86-xlibs-7.0-r6"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir usr
	mv emul/linux/x86/usr/lib usr/lib32 || die
	rmdir emul/linux/x86/usr emul/linux/x86 emul/linux emul || die
}

src_install() {
	cp -a "${WORKDIR}"/* "${D}"/ || die
}
