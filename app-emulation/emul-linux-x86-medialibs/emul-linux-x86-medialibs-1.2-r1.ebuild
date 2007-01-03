# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-medialibs/emul-linux-x86-medialibs-1.2-r1.ebuild,v 1.1 2007/01/03 07:35:08 vapier Exp $

DESCRIPTION="Media libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="nostrip"

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-2.5.5-r1
	>=app-emulation/emul-linux-x86-soundlibs-2.5-r1"

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
