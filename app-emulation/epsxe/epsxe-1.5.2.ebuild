# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/epsxe/epsxe-1.5.2.ebuild,v 1.4 2002/07/27 13:10:13 stubear Exp $

S=${WORKDIR}
DESCRIPTION="ePSXe Playstation Emulator"
HOMEPAGE="http://www.epsxe.com"
LICENSE="Freeware"
KEYWORDS="x86"
SLOT="0"    

use opengl && GLDEPEND="app-emulation/psemu-gpupetemesagl"
use opengl || GLDEPEND="app-emulation/psemu-peopssoftgpu"

DEPEND="app-arch/unzip"
RDEPEND=">=dev-libs/glib-1.2
	=x11-libs/gtk+-1.2*
	=sys-libs/ncurses-5*
	=sys-libs/zlib-1*
	net-misc/wget
	app-emulation/psemu-peopsspu
	${GLDEPEND}"

SRC_URI="http://download.epsxe.com/files/epsxe152lin.zip"

# For some strange reason, strip truncates the whole file
RESTRICT="nostrip"

src_unpack() {
	unzip ${DISTDIR}/${A}
}

src_install () {
	dobin ${FILESDIR}/epsxe

	insinto /opt/epsxe
	doins epsxe
	chmod 755 ${D}/opt/epsxe/epsxe

	insinto /usr/lib/psemu/cheats
	doins cheats/*

	dodoc docs/*
}
