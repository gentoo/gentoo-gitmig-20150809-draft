# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-1.0.ebuild,v 1.3 2004/02/20 06:08:33 mr_bones_ Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk+ 1/2 for emulation of 32bit x86 on amd64/ia64"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-gtklibs-1.0.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"

DEPEND=">=app-emulation/emul-linux-x86-xlibs-1.0"

src_unpack () {
	unpack ${A}
}

src_install() {
	cd ${WORKDIR}
	mkdir -p ${D}/emul/linux/x86
	mkdir -p ${D}/emul/linux/x86/lib
	mkdir -p ${D}/emul/linux/x86/usr/lib
	mkdir -p ${D}/lib
	mkdir -p ${D}/usr
	cp -Rpvf ${WORKDIR}/* ${D}/emul/linux/x86
}
