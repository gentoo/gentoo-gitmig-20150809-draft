# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
NAME="xmms-xosd"
S=${WORKDIR}/${NAME}-${PV}
DESCRIPTION="xmms plugin for overlaying song titles in X-Windows - X-On-Screen-Display"
SRC_URI="http://www.ignavus.net/xosd-${PV}.tar.gz"
HOMEPAGE="http://www.ignavus.net/"
DEPEND="virtual/x11
	virtual/glibc
	>=media-sound/xmms-1.2.6-r1
	=x11-libs/xosd-0.7.0"
RDEPEND="${DEPEND}"
LICENSE="GPL"
SLOT="0"
src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/xosd-${PV}
	patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff
	patch -p0 < ${FILESDIR}/${P}-xmms_osd.c-gentoo.diff
}
src_compile() {
	cd ${WORKDIR}/xosd-${PV}
	make || die
}
src_install () {
	cd ${WORKDIR}/xosd-${PV}
	insinto /usr/lib/xmms/General
	doins libxmms_osd.so
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so
	into /usr
	dodoc AUTHORS ChangeLog COPYING README
}
