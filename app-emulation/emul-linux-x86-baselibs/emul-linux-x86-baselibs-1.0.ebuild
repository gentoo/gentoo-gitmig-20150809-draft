# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-1.0.ebuild,v 1.10 2004/08/16 20:46:40 lv Exp $

DESCRIPTION="Base libraries for emulation of 32bit x86 on amd64/ia64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-baselibs-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="virtual/libc
		!app-emulation/emul-linux-x86-glibc"

S=${WORKDIR}

src_install() {
	dodir /emul/linux/x86/lib /emul/linux/x86/usr/lib
	dodir /lib /usr /etc/env.d
	cp -Rpvf ${WORKDIR}/* ${D}/emul/linux/x86/
	ln -sf /emul/linux/x86/lib/ld-linux.so.2 ${D}/lib/ld-linux.so.2
	ln -sf /emul/linux/x86/lib ${D}/lib32
	ln -sf /emul/linux/x86/usr/lib ${D}/usr/lib32
	cp ${FILESDIR}/75emul-linux-x86-base ${D}/etc/env.d
}
