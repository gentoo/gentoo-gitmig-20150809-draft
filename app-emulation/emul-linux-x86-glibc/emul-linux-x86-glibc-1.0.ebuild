# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-glibc/emul-linux-x86-glibc-1.0.ebuild,v 1.1 2004/07/31 12:47:02 kugelfang Exp $

DESCRIPTION="GNU C Library for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~kugelfang/emul-linux-x86-glibc-${PV}.tar.bz2
	mirror://gentoo/distfiles/emul-linux-x86-glibc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}

src_install() {
	cp -aRpvf ${WORKDIR}/* ${D}/
}
