# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsndfile/libsndfile-0.0.28.ebuild,v 1.1 2002/05/24 07:05:41 agenkin Exp $

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.zipworld.com.au/~erikd/libsndfile/"

LICENSE="LGPL-2.1"

DEPEND="virtual/glibc"
SRC_URI="http://www.zipworld.com.au/~erikd/libsndfile/${P}.tar.gz"

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}
