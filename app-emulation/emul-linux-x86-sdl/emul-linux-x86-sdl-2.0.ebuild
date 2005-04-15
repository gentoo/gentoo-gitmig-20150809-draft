# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-2.0.ebuild,v 1.1 2005/04/15 21:15:39 blubb Exp $

DESCRIPTION="32bit SDL emulation for amd64"
SRC_URI="http://fermat.ma.rhul.ac.uk/~herbie/emul/emul-linux-x86-sdl-${PV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-soundlibs-2.0
	>=app-emulation/emul-linux-x86-xlibs-2.0"

src_install() {
	mkdir -p ${D}
	# everything should already be in the right place :)
	cp -Rpvf ${WORKDIR}/* ${D}/
}
