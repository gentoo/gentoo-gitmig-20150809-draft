# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsndfile/libsndfile-1.0.1.ebuild,v 1.7 2004/03/19 07:56:04 mr_bones_ Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.zipworld.com.au/~erikd/libsndfile/"
SRC_URI="http://www.zipworld.com.au/~erikd/libsndfile/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

src_compile () {

	econf || die "configure failed"

	make || die "make failed"

}

src_install () {

	einstall || die "make install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}
