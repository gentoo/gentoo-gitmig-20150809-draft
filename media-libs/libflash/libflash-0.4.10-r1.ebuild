# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libflash/libflash-0.4.10-r1.ebuild,v 1.1 2002/06/14 23:50:13 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A library for flash animations"
SRC_URI="http://www.directfb.org/download/contrib/${P}.tar.gz"
HOMEPAGE="http://www.swift-tools.com/Flash/"

DEPEND="virtual/glibc
	media-libs/jpeg
	sys-libs/zlib"
RDEPEND="${DEPEND}"

LICENSE="GPL"
SLOT="0"

src_unpack() {

	unpack ${P}.tar.gz

	# patch to fix the sqrt not defined problem in gcc3.1
	# It should be ok with gcc2.95 thanks to Doug Goldstein <dougg@ufl.edu> (Cardoe)
	patch -p0 < ${FILESDIR}/${P}-sqrt.patch || die

}

src_compile() {

	econf || die "Configure failed"
	emake || die "Make failed"

}

src_install () {

	make DESTDIR=${D} install || die "Install failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README

}

