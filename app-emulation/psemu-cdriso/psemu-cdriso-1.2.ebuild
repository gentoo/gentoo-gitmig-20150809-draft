# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-cdriso/psemu-cdriso-1.2.ebuild,v 1.7 2003/02/13 07:15:25 vapier Exp $

DESCRIPTION="PSEmu plugin to read CD-images"
HOMEPAGE="http://www.pcsx.net"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
SLOT="0"
DEPEND="sys-libs/zlib
	sys-apps/bzip2
	x11-libs/gtk+"
IUSE=""

SRC_URI="http://linux.pcsx.net/downloads/plugins/cdriso-${PV}.tgz"
S=${WORKDIR}

src_compile() {
	cd src
	( echo CFLAGS = ${CFLAGS}
	  sed 's/CFLAGS =/CFLAGS +=/' < Makefile ) >Makefile.gentoo
	emake -f Makefile.gentoo
}

src_install () {
	insinto /usr/lib/psemu/plugins
	doins src/libcdr*
	chmod 755 ${D}/usr/lib/psemu/plugins/*
	dodoc ReadMe.txt
}

