# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-xosd/xmms-xosd-0.7.0.ebuild,v 1.1 2002/08/30 08:35:31 seemant Exp $

S=${WORKDIR}/${P#xmms-}
DESCRIPTION="xmms plugin for overlaying song titles in X-Windows - X-On-Screen-Display"
SRC_URI="http://www.ignavus.net/${P#xmms-}.tar.gz"
HOMEPAGE="http://www.ignavus.net/"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

DEPEND="virtual/x11
	media-sound/xmms
	=x11-libs/xosd-0.7.0"

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
