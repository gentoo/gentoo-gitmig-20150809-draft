# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-xosd/xmms-xosd-2.0.1.ebuild,v 1.2 2003/01/01 04:36:04 vapier Exp $

MY_P=${PN/xmms-}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="xmms plugin for overlaying song titles in X-Windows - X-On-Screen-Display"
SRC_URI="http://www.ignavus.net/${MY_P}.tar.gz"
HOMEPAGE="http://www.ignavus.net/software.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/x11
	virtual/glibc
	>=media-sound/xmms-1.2.6-r1
	~x11-libs/xosd-${PV}"

src_install() {
	insinto /usr/lib/xmms/General
	doins src/xmms_plugin/.libs/libxmms_osd.so
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so
	dodoc AUTHORS ChangeLog COPYING README
}
