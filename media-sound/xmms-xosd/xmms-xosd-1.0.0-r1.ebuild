# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
NAME=xosd-1.0.0
S=${WORKDIR}/${NAME}
DESCRIPTION="xmms plugin for overlaying song titles in X-Windows - X-On-Screen-Display"
SRC_URI="http://www.ignavus.net/${NAME}.tar.gz"
HOMEPAGE="http://www.ignavus.net/"
DEPEND="virtual/x11
	virtual/glibc
	>=media-sound/xmms-1.2.6-r1
	x11-libs/xosd"
RDEPEND="${DEPEND}"
LICENSE="GPL"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${NAME}
	./autogen.sh
	patch Makefile < ${FILESDIR}/Makefile-gentoo.diff
	patch src/xmms_osc.c < ${FILESDIR}/xmms_osd.c-gentoo.diff
}
src_compile() {
	cd ${S}
	./configure --prefix=/usr --host=${CHOST} || die
	make || die
}
src_install () {
	cd ${WORKDIR}/${NAME}
	insinto /usr/lib/xmms/General
	doins src/.libs/libxmms_osd.so src/.libs/libxmms_osd.so.0 src/.libs/libxmms_osd.so.0.0.0 
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so.0
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so.0.0.0
	into /usr
	dodoc AUTHORS ChangeLog COPYING README
}
