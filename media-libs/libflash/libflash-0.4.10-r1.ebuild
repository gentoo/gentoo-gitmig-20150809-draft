# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libflash/libflash-0.4.10-r1.ebuild,v 1.11 2003/11/27 20:30:56 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A library for flash animations"
SRC_URI="http://www.directfb.org/download/contrib/${P}.tar.gz"
HOMEPAGE="http://www.swift-tools.com/Flash/"

DEPEND="media-libs/jpeg
	sys-libs/zlib"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~amd64"

src_unpack() {
	unpack ${A} ; cd ${S}

	# patch to fix the sqrt not defined problem in gcc3.1
	# It should be ok with gcc2.95 thanks to Doug Goldstein 
	# <dougg@ufl.edu> (Cardoe)
	epatch ${FILESDIR}/${P}-sqrt.patch

}

src_install () {

	make DESTDIR=${D} install || die "Install failed"
	dodoc AUTHORS COPYING README

}
