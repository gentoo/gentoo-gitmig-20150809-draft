# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-1.1-r1.ebuild,v 1.2 2004/07/18 19:46:23 lv Exp $

DESCRIPTION="X11R6 libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-xlibs-1.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}

src_install() {
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

	# ARGH, forgot to include env.d file, workaround till next version
	# DONT define opengl stuff here anymore, opengl-update is handling this.
	echo "LDPATH=/emul/linux/x86/usr/X11R6/lib" > ${D}/etc/env.d/75emul-linux-x86-xlibs
	#mv -v ${WORKDIR}/etc/env.d/75emul-linux-x86-xlibs ${D}/etc/env.d/
	#rm -Rf ${WORKDIR}/etc

	# ARGH2, libxrx.so[.6] must be symlinks !
	cd ${WORKDIR}/usr/X11R6/lib
	rm -f libxrx.so
	rm -f libxrx.so.6
	ln -sf libxrx.so.6.3 libxrx.so
	ln -sf libxrx.so.6.3 libxrx.so.6

	cp -Rpvf ${WORKDIR}/* ${D}/emul/linux/x86
}
