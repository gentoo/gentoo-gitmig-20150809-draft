# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-2.3.ebuild,v 1.5 2007/07/02 13:56:30 peper Exp $

DESCRIPTION="32bit SDL emulation for amd64"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://dev.gentoo.org/~herbs/emul/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE=""

DEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-soundlibs-2.0
	>=app-emulation/emul-linux-x86-xlibs-2.0"

RESTRICT="strip"

src_install() {
	cp -RPvf ${WORKDIR}/* ${D}/
}
