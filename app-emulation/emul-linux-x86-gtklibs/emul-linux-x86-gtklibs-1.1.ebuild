# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-1.1.ebuild,v 1.3 2004/06/16 09:27:45 kloeri Exp $

DESCRIPTION="Gtk+ 1/2 for emulation of 32bit x86 on amd64"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-gtklibs-1.1.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=app-emulation/emul-linux-x86-xlibs-1.1"

src_install() {
	cd ${WORKDIR}
	mkdir -p ${D}/emul/linux/x86
	mkdir -p ${D}/emul/linux/x86/usr/lib
	mkdir -p ${D}/etc/env.d
	mv ${WORKDIR}/etc/env.d/50emul-linux-x86-gtklibs ${D}/etc/env.d/
	rm -Rf ${WORKDIR}/etc
	cp -Rpvf ${WORKDIR}/* ${D}/emul/linux/x86
}
