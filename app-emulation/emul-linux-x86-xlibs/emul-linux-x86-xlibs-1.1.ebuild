# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-1.1.ebuild,v 1.2 2004/04/14 05:50:42 lv Exp $

DESCRIPTION="X11R6 libraries for emulation of 32bit x86 on amd64"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-xlibs-1.1.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-*"

DEPEND="virtual/glibc"

src_unpack () {
	unpack ${A}
}

src_install() {
	cd ${WORKDIR}
	mkdir -p ${D}/emul/linux/x86
	mkdir -p ${D}/emul/linux/x86/usr/lib/opengl
	mkdir -p ${D}/emul/linux/x86/usr/X11R6/lib/X11/locale
	mkdir -p ${D}/emul/linux/x86/usr/X11R6/lib/modules/dri
	mkdir -p ${D}/emul/linux/x86/usr/X11R6/lib/modules/fonts
	mkdir -p ${D}/emul/linux/x86/usr/X11R6/lib/modules/codeconv
	mkdir -p ${D}/emul/linux/x86/usr/X11R6/lib/modules/extensions
	mkdir -p ${D}/emul/linux/x86/usr/X11R6/lib/modules/drivers
	mkdir -p ${D}/emul/linux/x86/usr/X11R6/lib/modules/input
	mkdir -p ${D}/etc/env.d
	mv ${WORKDIR}/etc/env.d/75emul-linux-x86-xlibs ${D}/etc/env.d/
	rm -Rf ${WORKDIR}/etc
	cp -Rpvf ${WORKDIR}/* ${D}/emul/linux/x86
}
