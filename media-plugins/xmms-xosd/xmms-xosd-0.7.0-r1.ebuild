# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-xosd/xmms-xosd-0.7.0-r1.ebuild,v 1.1 2002/08/30 08:35:31 seemant Exp $

S=${WORKDIR}/${P#xmms-}
DESCRIPTION="xmms plugin for overlaying song titles in X-Windows - X-On-Screen-Display"
SRC_URI="http://www.ignavus.net/${P#xmms-}.tar.gz"
HOMEPAGE="http://www.ignavus.net/"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

DEPEND="virtual/x11
	media-sound/xmms
	=x11-libs/${P#xmms-}"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff
	patch -p0 < ${FILESDIR}/${P}-xmms_osd.c-gentoo.diff
}
src_compile() {
	make || die
}
src_install () {
	insinto /usr/lib/xmms/General
	doins libxmms_osd.so
	fperms 0755 /usr/lib/xmms/General/libxmms_osd.so
	into /usr
	dodoc AUTHORS ChangeLog COPYING README
}
