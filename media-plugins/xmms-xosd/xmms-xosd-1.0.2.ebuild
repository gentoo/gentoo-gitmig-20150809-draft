# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

MY_P=${PN/xmms-}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="xmms plugin for overlaying song titles in X-Windows - X-On-Screen-Display"
SRC_URI="http://www.ignavus.net/${MY_P}.tar.gz"
HOMEPAGE="http://www.ignavus.net/"
DEPEND="virtual/x11
	virtual/glibc
	>=media-sound/xmms-1.2.6-r1
	>=x11-libs/xosd-1.0.2"
RDEPEND="${DEPEND}"
LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 ppc"

src_compile() {
	econf || die
	make || die
}

src_install () {
	cd ${S}
	insinto /usr/lib/xmms/General
	doins src/xmms_plugin/.libs/libxmms_osd.so src/xmms_plugin/.libs/libxmms_osd.so.0 src/xmms_plugin/.libs/libxmms_osd.so.0.0.0 
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so.0
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so.0.0.0
	into /usr
	dodoc AUTHORS ChangeLog COPYING README
}
