# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.2.3-r1.ebuild,v 1.1 2002/03/21 17:28:36 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An elegant API for accessing audio files"
SRC_URI="ftp://oss.sgi.com/projects/audiofile/download/${P}.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/audiofile/"

DEPEND="virtual/glibc"

src_compile() {
	#libtoolize to fix "relink bug"
	libtoolize --force --copy
	aclocal
	automake --add-missing
	autoconf

	./configure --host=${CHOST} \
		--prefix=/usr || die

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc ACKNOWLEDGEMENTS AUTHORS COPYING* ChangeLog README TODO
	dodoc NEWS NOTES
}

