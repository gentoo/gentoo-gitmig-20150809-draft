# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmovtar/libmovtar-0.1.3-r1.ebuild,v 1.15 2005/08/21 02:45:34 halcy0n Exp $

IUSE="mmx"

inherit eutils libtool

DESCRIPTION="Movtar tools and library for MJPEG video"
SRC_URI="http://download.sourceforge.net/mjpeg/${P}.tar.gz"
HOMEPAGE="http://mjpeg.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"

DEPEND="=dev-libs/glib-1.2*
	>=media-libs/jpeg-6b
	>=media-libs/libsdl-1.2.2
	x86? ( mmx? ( media-libs/jpeg-mmx ) )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/jpegint.h .
	cp movtar_play.c movtar_play.c.orig
	sed -e "s:#include <jinclude.h>::" movtar_play.c.orig > movtar_play.c

	# Fix building with gcc4
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-m4.patch
	# bug #101397
	epatch ${FILESDIR}/${P}-asm.patch
}

src_compile() {
	elibtoolize
	econf --disable-dependency-tracking || die
	emake || die
}


src_install() {
	einstall || die

	dodoc AUTHORS README* NEWS
}
