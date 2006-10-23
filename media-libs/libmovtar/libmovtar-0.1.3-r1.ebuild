# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmovtar/libmovtar-0.1.3-r1.ebuild,v 1.19 2006/10/23 12:14:41 blubb Exp $

IUSE="mmx"

inherit eutils libtool

DESCRIPTION="Movtar tools and library for MJPEG video"
SRC_URI="http://download.sourceforge.net/mjpeg/${P}.tar.gz"
HOMEPAGE="http://mjpeg.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"

DEPEND=">=media-libs/jpeg-6b-r4
	>=media-libs/libsdl-1.2.2
	=dev-libs/glib-1.2*
	mmx? ( media-libs/jpeg-mmx )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:#include <jinclude.h>::" movtar_play.c

	# Fix building with gcc4
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-m4.patch
	# bug #101397
	epatch ${FILESDIR}/${P}-asm.patch

	elibtoolize
}

src_install() {
	einstall || die

	dodoc AUTHORS README* NEWS
}
