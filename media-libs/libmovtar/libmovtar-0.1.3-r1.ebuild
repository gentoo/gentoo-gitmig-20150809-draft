# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmovtar/libmovtar-0.1.3-r1.ebuild,v 1.10 2004/03/19 07:56:04 mr_bones_ Exp $

IUSE="mmx"

inherit libtool

S=${WORKDIR}/${P}
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

}

src_compile() {

	elibtoolize
	econf || die
	emake || die

}


src_install() {

	einstall || die

	dodoc AUTHORS COPYING README* NEWS

}
