# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsndfile/libsndfile-0.0.28.ebuild,v 1.10 2004/07/14 20:16:07 agriffis Exp $

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.zipworld.com.au/~erikd/libsndfile/"
SRC_URI="http://www.zipworld.com.au/~erikd/libsndfile/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc sparc "
IUSE=""

DEPEND="virtual/libc"

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}
