# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/epsxe/epsxe-1.5.2.ebuild,v 1.11 2003/07/13 22:00:26 vapier Exp $

DESCRIPTION="ePSXe Playstation Emulator"
HOMEPAGE="http://www.epsxe.com/"
SRC_URI="http://download.epsxe.com/files/epsxe152lin.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl"

DEPEND="app-arch/unzip"
RDEPEND=">=dev-libs/glib-1.2
	=x11-libs/gtk+-1.2*
	=sys-libs/ncurses-5*
	=sys-libs/zlib-1*
	net-misc/wget
	app-emulation/psemu-peopsspu
	|| (
		opengl? ( app-emulation/psemu-gpupetemesagl )
		app-emulation/psemu-peopssoftgpu
	)"

S=${WORKDIR}

# For some strange reason, strip truncates the whole file
RESTRICT="nostrip"

src_install() {
	dobin ${FILESDIR}/epsxe

	exeinto /opt/epsxe
	doexe epsxe

	insinto /usr/lib/psemu/cheats
	doins cheats/*

	insinto /etc/epsxe
	doins keycodes.lst

	dodoc docs/*
}
