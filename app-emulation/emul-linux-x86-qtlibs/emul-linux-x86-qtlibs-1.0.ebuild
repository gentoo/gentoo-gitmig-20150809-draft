# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-1.0.ebuild,v 1.1 2004/04/13 17:45:26 kugelfang Exp $

DESCRIPTION="QT 2/3 libraries for emulation of 32bit x86 on amd64"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-qtlibs-1.0.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"

DEPEND="virtual/glibc
	=app-emulation/emul-linux-x86-xlibs-1.1"

src_unpack () {
	unpack ${A}
}

src_install() {
	cd ${WORKDIR}
	mkdir -p ${D}/emul/linux/x86
	mkdir -p ${D}/emul/linux/x86/usr/qt/2/lib
	mkdir -p ${D}/emul/linux/x86/usr/qt/3/lib
	mkdir -p ${D}/emul/linux/x86/usr/qt/3/plugins
	mkdir -p ${D}/etc/env.d
	mv ${WORKDIR}/etc/env.d/45emul-linux-x86-qtlibs ${D}/etc/env.d/
	rm -Rf ${WORKDIR}/etc
	cp -Rpvf ${WORKDIR}/* ${D}/emul/linux/x86
}
