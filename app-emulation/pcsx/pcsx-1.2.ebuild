# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pcsx/pcsx-1.2.ebuild,v 1.3 2002/07/27 15:32:53 stubear Exp $

S=${WORKDIR}
DESCRIPTION="Playstation emulator"
HOMEPAGE="http://www.pcsx.net"
LICENSE="GPL"
KEYWORDS="x86"
SLOT="0"  

use opengl && GLDEPEND="app-emulation/psemu-gpupetemesagl"
use opengl || GLDEPEND="app-emulation/psemu-peopssoftgpu"

DEPEND="sys-libs/zlib
	app-arch/unzip
	x11-libs/gtk+
	gnome-base/libglade"

RDEPEND="net-misc/wget
	app-emulation/psemu-cdr
	app-emulation/psemu-cdriso
	app-emulation/psemu-padxwin
	app-emulation/psemu-padjoy
	app-emulation/psemu-peopsspu
	${GLDEPEND}"

SRC_URI="http://www.pcsx.net/downloads/${PN}src${PV}.zip"

src_unpack() {
	cd ${WORKDIR}
	set
	unzip -a ${DISTDIR}/$(echo ${A} | cut -f1 -d\ )
	patch -p0 < ${FILESDIR}/ix86.h.diff
}

src_compile() {
	cd PcsxSrc/Linux

	# Change some defaults...
	sed -e 's:Plugin/:/usr/lib/psemu/plugins/:' \
	    -e 's:Bios/:/usr/lib/psemu/bios/:' \
	    -e 's:Pcsx.cfg:~/.pcsx/config:' \
	    <LnxMain.c >LnxMain.tmp
	mv -f LnxMain.tmp LnxMain.c

	emake OPTIMIZE="${CFLAGS} -fPIC -fomit-frame-pointer -finline-functions -ffast-math" || die
	mv pcsx pcsx.bin
}

src_install () {
	dobin PcsxSrc/Linux/pcsx.bin
	dobin ${FILESDIR}/pcsx
	dodoc PcsxSrc/Docs/*
}
