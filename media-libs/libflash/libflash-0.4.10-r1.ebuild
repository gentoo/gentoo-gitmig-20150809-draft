# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libflash/libflash-0.4.10-r1.ebuild,v 1.12 2004/02/07 20:26:46 vapier Exp $

DESCRIPTION="A library for flash animations"
HOMEPAGE="http://www.swift-tools.com/Flash/"
SRC_URI="http://www.directfb.org/download/contrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"

DEPEND="media-libs/jpeg
	sys-libs/zlib"

src_unpack() {
	unpack ${A} ; cd ${S}

	# patch to fix the sqrt not defined problem in gcc3.1
	# It should be ok with gcc2.95 thanks to Doug Goldstein 
	# <dougg@ufl.edu> (Cardoe)
	epatch ${FILESDIR}/${P}-sqrt.patch
}

src_install() {
	make DESTDIR=${D} install || die "Install failed"
	dodoc AUTHORS COPYING README
}
