# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-1.0.ebuild,v 1.4 2004/06/27 23:03:10 vapier Exp $

DESCRIPTION="QT 2/3 libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-qtlibs-1.0.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/libc
	=app-emulation/emul-linux-x86-xlibs-1.1"

S=${WORKDIR}

src_install() {
	mkdir -p ${D}/emul/linux/x86
	mkdir -p ${D}/emul/linux/x86/usr/qt/2/lib
	mkdir -p ${D}/emul/linux/x86/usr/qt/3/lib
	mkdir -p ${D}/emul/linux/x86/usr/qt/3/plugins
	mkdir -p ${D}/etc/env.d
	mv ${WORKDIR}/etc/env.d/45emul-linux-x86-qtlibs ${D}/etc/env.d/
	rm -Rf ${WORKDIR}/etc
	cp -Rpvf ${WORKDIR}/* ${D}/emul/linux/x86
}
